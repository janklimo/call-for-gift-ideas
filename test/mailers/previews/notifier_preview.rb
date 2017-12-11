class NotifierPreview < ActionMailer::Preview
  def send_call
    call = Call.last
    Notifier.send_call(call)
  end

  def send_wishlist
    call = Call.where(recipient_name: 'Recipient Homie').first
    Notifier.send_wishlist(call)
  end
end
