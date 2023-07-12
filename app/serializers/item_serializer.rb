class ItemSerializer
  include JSONAPI::Serializer
  # set_id {3}
  # set_type "giggles"
  attributes :name, :description, :unit_price, :merchant_id

end
