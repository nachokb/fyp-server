class Report < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :sightings

  has_attached_file :picture, 
    s3_credentials: Rails.root + '/config/s3.yml',
    bucket: 'inakathoon-kiss',
    default_url: "http://inakathoon-kiss.s3.amazonaws.com/IMG_20140518_182234.jpg"

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

  PER_PAGE = 20

  mapping do
    indexes :id,                 type: 'integer'
    indexes :geo_point,          type: 'geo_point'
    indexes :email,              type: 'string', index: :not_analyzed
    indexes :description,        type: 'string', index: :not_analyzed
    indexes :species,            type: 'string', index: :not_analyzed
    indexes :race,               type: 'string', index: :not_analyzed
    indexes :size,               type: 'string', index: :not_analyzed
    indexes :color,              type: 'string', index: :not_analyzed
    indexes :age,                type: 'string', index: :not_analyzed
    indexes :sex,                type: 'string', index: :not_analyzed
    indexes :image,              type: 'string', index: :not_analyzed
    indexes :created_at,         type: 'date'
    indexes :status,             type: 'string', index: :not_analyzed
    indexes :name,               type: 'string', index: :not_analyzed
    indexes :type,               type: 'string', index: :not_analyzed
  end

  def to_indexed_json
    geo_point = lat && lon ? {geo_point: {lat: lat, lon: lon}} : {}
    { 
      id: id,
      email: email,
      description: description,
      species: species,
      race: race,
      size: size,
      color: color,
      age: age,
      sex: sex,
      image: picture.url,
      created_at: created_at,
      status: status,
      name: name,
      type: "report"
    }.merge(geo_point).to_json
  end

  def self.search_all location, filters, page = 1
    reports = Report.search do
      from (page - 1) * PER_PAGE
      size PER_PAGE

      unless filters.blank?
        filter 'and', filters.map{|key, value|
          {term: {key => value}}
        }
      end

      if location
        sort do
          by :_geo_distance, geo_point: [location[:lon].to_f, location[:lat].to_f], order: 'asc', unit: 'meters'
        end
      else
        sort {by :created_at, 'desc'}
      end
    end

    reports.as_json(except: [:_type, :_index, :_version, :_explanation, :_score, :sort, :highlight])
  end

  def candidates page = 1
    report = self
    filters = Hash[*%w(name species race size color age sex).map {|msg| 
      report.send(msg).present? ? ([msg, report.send(msg)]) : nil 
    }.compact.flatten]

    sightings = Sighting.search do
      from (page - 1) * PER_PAGE
      size PER_PAGE

      unless filters.blank?
        filter 'or', filters.map{|key, value|
          {term: {key => value}}
        }
      end

      if report.lat and report.lon
        sort do
          by :_geo_distance, geo_point: [report.lon, report.lat], order: 'asc'
        end
      else
        sort {by :created_at, 'desc'}
      end
    end

    sightings.as_json(except: [:_type, :_index, :_version, :_explanation, :_score, :sort, :highlight])
  end
end
