require "rails_helper"

RSpec.describe Address, type: :model do
  describe "associations" do
    context "with belong to" do
      it {is_expected.to belong_to(:user) }
    end

    context "with has many" do
      it { is_expected.to have_many(:orders).dependent(:destroy) }
    end
  end

  describe "validations" do
    context "when validate attributes" do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
