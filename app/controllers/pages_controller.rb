# frozen_string_literal: true

class PagesController < ApplicationController
  def landing
    @total_count = Call.total_wishlist_items_count
  end
end
