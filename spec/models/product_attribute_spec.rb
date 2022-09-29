require "rails_helper"

RSpec.describe ProductAttribute, type: :model do
  describe "associations" do
    context "with belong to" do
      it {is_expected.to belong_to(:product) }
      it {is_expected.to belong_to(:size) }
    end

    context "with has many" do
      it { is_expected.to have_many(:order_details).dependent(:destroy) }
    end
  end

  describe "validations" do
    context "when validate attributes" do
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to  validate_numericality_of(:price), :only_integer => true,
          :greater_than => Settings.const.products.attribute.min,
          :less_than_or_equal_to => Settings.const.products.attribute.max
        }
      it { is_expected.to validate_presence_of(:quantity) }
      it { is_expected.to  validate_numericality_of(:quantity), :only_integer => true,
          :greater_than => Settings.const.products.attribute.min,
          :less_than_or_equal_to => Settings.const.products.attribute.max
        }
    end
  end
end
