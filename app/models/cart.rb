class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :product_attributes, through: :line_items

  def sub_total
    line_items.reduce(0){|a, e| a + e.total_price.to_i}
  end
end
