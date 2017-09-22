# frozen_string_literal: true

class Product < ApplicationRecord
  has_attached_file :image,
    url: ':s3_domain_url',
    path: 'products/:id/:basename.:hash.:extension',
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET'],
      bucket: ENV['S3_BUCKET']
    },
    s3_region: ENV['S3_REGION'],
    hash_secret: "JUST4URLUNIQUENESS",
    s3_protocol: "https"

  validates_attachment_content_type :image,
    content_type: /\Aimage\/.*\Z/
end
