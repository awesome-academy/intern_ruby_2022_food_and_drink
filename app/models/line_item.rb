class LineItem < ApplicationRecord
  belongs_to :product_attribute
  belongs_to :cart

  def total_price
    helper.number_to_currency(quantity * product_attribute.price, negative_format: "(%u%n)")
  end
  private

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end
end
