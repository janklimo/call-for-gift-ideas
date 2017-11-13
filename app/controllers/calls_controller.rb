class CallsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @call = Call.active.find_by(slug: params[:id])
    @call_json = ActiveModelSerializers::SerializableResource
      .new(@call, {}).to_json
    redirect_to root_url unless @call
  end

  def update
    call = Call.active.find_by(slug: params[:id])

    unless call
      redirect_to root_url
      return
    end

    if call.demo?
      render json: { status: 'ok' }
      return
    end

    if call.update(call_params.merge(status: :completed))
      render json: { status: 'ok' }
    else
      render status: 422, json: { status: 'failed' }
    end
  end

  def create
    call = Call.new(call_params)

    if call.save
      render json: { status: 'ok' }
      Notifier.send_call(call).deliver_now
    else
      render status: 422, json: { status: 'failed' }
    end
  end

  private

  def call_params
    params
      .require(:call)
      .permit(
        :sender_name,
        :sender_email,
        :recipient_name,
        :recipient_email,
        :recipient_sex,
        preferences: [],
      )
  end
end
