class CallSerializer < ActiveModel::Serializer
  attributes :slug, :recipient_name, :products

  def products
    ActiveModelSerializers::SerializableResource.new(
      object.products.order("RANDOM()"),
      each_serializer: ProductSerializer
    )
  end
end
