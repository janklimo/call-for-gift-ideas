class CallSerializer < ActiveModel::Serializer
  attributes :recipient_name, :products

  def products
    ActiveModelSerializers::SerializableResource.new(
      Product.all,
      each_serializer: ProductSerializer
    )
  end
end
