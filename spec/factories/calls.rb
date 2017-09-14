FactoryGirl.define do
  factory :call do
    recipient_name 'Jon'
    recipient_email 'jon@snow.com'
    sender_email 'elon@musk.com'
    preferences "[1]"
  end
end
