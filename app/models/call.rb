# frozen_string_literal: true

class Call < ApplicationRecord
  enum status: [:active, :completed]
  enum recipient_sex: [:male, :female]

  before_validation :generate_slug, on: :create

  validates :slug, :recipient_name, :recipient_email,
    :sender_name, :sender_email, presence: true

  def products
    Product.where(target_audience: Call.recipient_sexes[recipient_sex])
  end

  def product_urls
    products.map(&:image_url)
  end

  def self.total_wishlist_items_count
    Call.pluck("SUM(array_length(preferences, 1))").first
  end

  private

  def generate_slug
    generator = TokenGenerator.new

    begin
      self.slug = generator.token
    end while self.class.exists?(slug: slug)
  end
end
