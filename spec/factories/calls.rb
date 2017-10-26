FactoryBot.define do
  factory :call do
    recipient_name 'Jon'
    recipient_email 'jon@snow.com'
    sender_email 'elon@musk.com'
    sender_name 'Elon'
    preferences "[1]"
  end
end
