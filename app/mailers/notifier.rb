class Notifier < ApplicationMailer
  def send_call(call)
    @call = call
    mail(to: @call.recipient_email, subject: "#{@call.recipient_name}, Pick Your Present 😻")
  end
end
