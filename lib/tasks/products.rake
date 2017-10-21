namespace :products do
  desc "Download all products from API"
  task load: :environment do
    res = HTTParty.get(
      "https://www.thisiswhyimbroke.com/api/gifts/gifts-for-men/clicks_score_amazon_available/1"
    )
    posts = JSON.parse(res.body)['posts']

    posts.each do |post|
      product = Product.find_or_initialize_by(external_id: post['id'])
      product.name = post['title']
      product.description = post['content']
      product.price = post['price']
      product.url = post['link']
      product.image_url = post['image']
      product.save!

      STDOUT.puts "Saved product \"#{post['title']}\""
    end
  end
end

