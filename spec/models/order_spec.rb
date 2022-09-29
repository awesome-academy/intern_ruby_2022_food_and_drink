require "rails_helper"

RSpec.describe Order, type: :model do
  let!(:order){ FactoryBot.create(:order, :status => 1) }
  describe "associations" do
    context "with belong to" do
      it {is_expected.to belong_to(:user) }
      it {is_expected.to belong_to(:address) }
    end

    context "with has many" do
      it { is_expected.to have_many(:order_details).dependent(:destroy) }
    end
  end

  describe "#statuses_i18n" do
    context "when i18n work with status" do
      it do
        expect(Order.statuses_i18n(order.status)).to match({
          I18n.t("orders.status.processing") => "processing",
          I18n.t("orders.status.rejected") => "rejected"
        })
      end
    end
  end

  describe "#status_i18n" do
    context "when i18n show" do
      it do
        expect(order.status_i18n).to eq(I18n.t("orders.status.#{order.status}"))
      end
    end
  end
end
