require "rails_helper"

RSpec.describe OrderDetail, type: :model do
  describe "associations" do
    context "with belong to" do
      it {is_expected.to belong_to(:product_attribute) }
      it {is_expected.to belong_to(:order) }
    end
  end
end
