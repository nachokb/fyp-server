class Report < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :sightings

  has_attached_file :picture, 
    s3_credentials: Rails.root + '/config/s3.yml',
    s3_bucket: 'inakathoon-kiss',
    default_url: "/images/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  mapping do
    indexes :id,                 type: 'integer'
    indexes :report_id,          type: 'string'
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
    { 
      id: id,
      report_id: report_id,
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
    }.to_json
  end
end
