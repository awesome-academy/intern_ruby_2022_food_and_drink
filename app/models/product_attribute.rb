class ProductAttribute < ApplicationRecord
  belongs_to :product
  belongs_to :size
  validates :price, presence: true, numericality: {
    only_integer: true,
    greater_than: Settings.const.products.attribute.min,
    less_than_or_equal_to: Settings.const.products.attribute.max
  }
  validates :quantity, presence: true, numericality: {
    only_integer: true,
    greater_than: Settings.const.products.attribute.min,
    less_than_or_equal_to: Settings.const.products.attribute.max
  }

  delegate :name, to: :product, prefix: true
  delegate :name, to: :size, prefix: true
end
