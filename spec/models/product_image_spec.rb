require "rails_helper"

RSpec.describe ProductImage, type: :model do
  describe "associations" do
    context "with belong to" do
      it {is_expected.to belong_to(:product) }
    end
  end

  describe "validations" do
    context "when validate attributes" do
      it { is_expected.to validate_presence_of(:image) }
      it { should_not allow_value("Inv4lid_").for(:image) }
    end
  end
end
