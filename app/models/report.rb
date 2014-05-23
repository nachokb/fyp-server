class Report < ActiveRecord::Base
  has_attached_file :picture, 
    s3_credentials: Rails.root + '/config/s3.yml',
    bucket: 'inakathoon-kiss',
    default_url: "/images/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
