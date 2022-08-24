class LineItem < ApplicationRecord
  belongs_to :product_attribute
  belongs_to :cart

  def total_price
    quantity * product_attribute.price
  end
end
