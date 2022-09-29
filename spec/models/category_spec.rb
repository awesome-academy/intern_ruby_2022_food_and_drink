require "rails_helper"

RSpec.describe Category, type: :model do
  let!(:category){ FactoryBot.create(:category) }
  let!(:category_1){ FactoryBot.create(:category) }
  describe "associations" do
    context "with has many" do
      it { is_expected.to have_many(:products).dependent(:destroy) }
    end
  end

  describe "validations" do
    context "when validate attributes" do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe "scopes" do
    context "with scopes sort" do
      it { expect(Category.latest_category).to eq([category_1, category]) }
    end
  end

  describe "#statuses_i18n" do
    context "when i18n work with status" do
      it do
        expect(Category.statuses_i18n).to match({
          I18n.t("category.status.active") => "active",
          I18n.t("category.status.inactive") => "inactive"
        })
      end
    end
  end

  describe "#status_i18n" do
    context "when i18n show" do
      it do
        expect(category.status_i18n).to eq(I18n.t("category.status.#{category.status}"))
      end
    end
  end
end
