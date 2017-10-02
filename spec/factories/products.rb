FactoryGirl.define do
  factory :product do
    name 'Drill'
    price 11.99
    description 'The best drill you can imagine.'
    image { File.new("#{Rails.root}/spec/support/fixtures/image.png") }
    target_audience :men
    url 'http://amzn.to/12345abc'
  end
end
