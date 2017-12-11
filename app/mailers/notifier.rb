class Notifier < ApplicationMailer
  def send_call(call)
    @call = call
    mail(to: @call.recipient_email, subject: "#{@call.recipient_name}, Pick Your Present 😻")
  end

  def send_wishlist(call)
    @call = call

    # we need the products in the order of preference
    product_subset = Product.where(id: @call.preferences)
    @products = @call.preferences.map do |id|
      product_subset.find { |p| p.id == id.to_i }
    end

    mail \
      to: @call.sender_email,
      subject: "#{@call.sender_name}, here's #{@call.recipient_name}'s wishlist! 💡"
  end
end
