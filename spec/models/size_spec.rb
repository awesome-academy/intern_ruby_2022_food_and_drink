require "rails_helper"

RSpec.describe Size, type: :model do
  describe "associations" do
    context "with has many" do
      it { is_expected.to have_many(:product_attributes).dependent(:destroy) }
    end
  end
end
