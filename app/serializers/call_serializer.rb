class CallSerializer < ActiveModel::Serializer
  attributes :slug, :recipient_name, :status
end
