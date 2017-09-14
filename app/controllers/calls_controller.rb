class CallsController < ApplicationController
  def show
    @call = Call.active.find_by(slug: params[:id])
    redirect_to root_url unless @call
  end
end
