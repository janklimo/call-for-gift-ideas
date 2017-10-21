# frozen_string_literal: true

class Product < ApplicationRecord
  enum target_audience: [:men, :women]
end
