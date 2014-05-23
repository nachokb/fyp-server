class Sighting < ActiveRecord::Base
  has_attached_file :picture, 
    s3_credentials: Rails.root + '/config/s3.yml',
    s3_bucket: 'inakathoon-kiss',
    default_url: "/images/missing.png"
end
