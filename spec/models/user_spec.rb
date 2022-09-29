require "rails_helper"

RSpec.describe User, type: :model do
  let(:user){ FactoryBot.create(:user) }
  auth_hash = OmniAuth::AuthHash.new({
    :provider => "google",
    :uid => "1234",
    :info => {
      :email => "user@example.com",
      :name => "Justin Bieber"
    }
  })
  describe "#statuses_i18n" do
    context "when i18n work with status" do
      it do
        expect(User.statuses_i18n).to match({
          I18n.t("user.status.active") => "active",
          I18n.t("user.status.block") => "block",
        })
      end
    end
  end

  describe "#status_i18n" do
    context "when i18n show" do
      it do
        expect(user.status_i18n).to eq(I18n.t("user.status.#{user.status}"))
      end
    end
  end

  describe "#from_omniauth" do
    it "creates a new user if one doesn't already exist" do
      expect(User.count).to eq(0)

      omniauth_user = User.from_omniauth(auth_hash)
      expect(User.count).to eq(1)
    end
  end
end
