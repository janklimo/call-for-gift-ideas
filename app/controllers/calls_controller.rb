class CallsController < ApplicationController
  def show
    @call = Call.active.find_by(slug: params[:id])
    @call_json = ActiveModelSerializers::SerializableResource
      .new(@call, {}).to_json
    redirect_to root_url unless @call
  end
end
