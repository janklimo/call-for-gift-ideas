class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image_url, :description, :url

  def image_url
    object.image.url
  end
end
