# frozen_string_literal: true

class PagesController < ApplicationController
  def landing
    @total_count = Call.total_wishlist_items_count
    @demo_male = Call.male.where(demo: true).last
    @demo_female = Call.female.where(demo: true).last
  end
end
