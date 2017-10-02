class CallSerializer < ActiveModel::Serializer
  attributes :recipient_name, :products

  def products
    ActiveModelSerializers::SerializableResource.new(
      object.products,
      each_serializer: ProductSerializer
    )
  end
end
