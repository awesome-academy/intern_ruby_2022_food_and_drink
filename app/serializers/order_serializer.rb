class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :note, :phone, :total
  attribute :details do |order|
    order.order_details
  end
end
