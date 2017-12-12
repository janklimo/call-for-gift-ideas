namespace :products do
  desc "Download all products from API"
  task load: :environment do
    @count = 0

    save_products(['men', 'dad'], :men)
    save_products(['women', 'mom'], :women)

    STDOUT.puts "Saved #{@count} products 🚀"
  end

  def save_products(sections, target_audience)
    sections.each do |section|
      (1..20).each do |page|
        res = HTTParty.get("https://www.thisiswhyimbroke.com/api/gifts/" \
                           "gifts-for-#{section}/clicks_score_amazon_available/#{page}")
        posts = JSON.parse(res.body)['posts']

        break if posts.size == 0

        posts.each do |post|
          product = Product.find_or_initialize_by(external_id: post['id'])
          product.name = post['title']
          product.description = ActionController::Base.helpers.strip_tags(post['content'])
          product.price = post['price']
          product.clicks_score = post['clicks_score']
          product.url = format_url(post['link'])
          product.image_url = post['image']
          product.target_audience = target_audience
          product.save!

          @count += 1

          STDOUT.puts "Saved product \"#{post['title']}\""
        end
      end
    end
  end

  def format_url(url)
    parsed = URI.parse(url)
    # screw affiliate tags
    parsed.query = nil if url.include? 'amazon.com/dp/'
    parsed.to_s
  end
end

