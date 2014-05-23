class Sighting < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :report

  has_attached_file :picture, 
    s3_credentials: Rails.root + '/config/s3.yml',
    bucket: 'inakathoon-kiss',
    default_url: "/images/missing.png"

  PER_PAGE = 20

  mapping do
    indexes :id,                 type: 'integer'
    indexes :geo_point,          type: 'geo_point'
    indexes :email,              type: 'string'
    indexes :description,        type: 'string'
    indexes :species,            type: 'string'
    indexes :race,               type: 'string'
    indexes :size,               type: 'string'
    indexes :color,              type: 'string'
    indexes :age,                type: 'string'
    indexes :sex,                type: 'string'
    indexes :image,              type: 'string'
    indexes :created_at,         type: 'date'
    indexes :status,             type: 'string'
    indexes :name,               type: 'string'
  end

  def to_indexed_json
    geo_point = lat && lon ? {geo_point: {lat: lat, lon: lon}} : {}
    { 
      id: id,
      geo_point: {
        lat: lat,
        lon: lon
      },
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
      name: name
    }.merge(geo_point).to_json
  end

  def self.search_all location, filters, page = 1
    reports = Sighting.search do
      from (page - 1) * PER_PAGE
      size PER_PAGE

      filter 'and', filters.map{|key, value|
        {term: {key => value}}
      }

      if location
        sort do
          by :_geo_distance, geo_point: [location[:lon].to_f, location[:lat].to_f], order: 'asc', unit: 'meters'
        end
      else
        sort {by :created_at, 'desc'}
      end
    end

    reports.as_json(except: [:_type, :_index, :_version, :_explanation])
  end

  def candidates page = 1
    sighting = self
    filters = Hash[*%w(name species race size color age sex).map {|msg| 
      sighting.send(msg).present? ? ([msg, sighting.send(msg)]) : nil 
    }.compact.flatten]

    reports = Report.search do
      from (page - 1) * PER_PAGE
      size PER_PAGE

      filter 'or', filters.map{|key, value|
        {term: {key => value}}
      }

      if sighting.lat and sighting.lon
        sort do
          by :_geo_distance, geo_point: [sighting.lon, sighting.lat], order: 'asc'
        end
      else
        sort {by :created_at, 'desc'}
      end
    end

    reports.as_json(except: [:_type, :_index, :_version, :_explanation])
  end
end
