class NotifierPreview < ActionMailer::Preview
  def send_call
    call = Call.last
    Notifier.send_call(call)
  end
end
