# frozen_string_literal: true

class Call < ApplicationRecord
  enum status: [:active, :completed]

  before_validation :generate_slug, on: :create

  validates :slug, :recipient_name, :recipient_email,
    :sender_email, presence: true

  private

  def generate_slug
    generator = TokenGenerator.new

    begin
      self.slug = generator.token
    end while self.class.exists?(slug: slug)
  end
end
