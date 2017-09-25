class CallsController < ApplicationController
  def show
    @call = Call.active.find_by(slug: params[:id])
    @call_json = ActiveModelSerializers::SerializableResource
      .new(@call, {}).to_json
    redirect_to root_url unless @call
  end

  def create
    call = Call.new(call_params)
    if call.save
      render json: { status: 'ok' }
    else
      render json: { status: 'failed' }
    end
  end

  private

  def call_params
    params.permit(
      :sender_name,
      :sender_email,
      :recipient_name,
      :recipient_email
    )
  end
end
