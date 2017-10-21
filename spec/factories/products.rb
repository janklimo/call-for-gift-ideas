FactoryGirl.define do
  factory :product do
    name 'Drill'
    price 11.99
    description 'The best drill you can imagine.'
    image_url 'http://i.imgur.com/2O8vjfv.gif'
    target_audience :men
    url 'http://amzn.to/12345abc'
  end
end
