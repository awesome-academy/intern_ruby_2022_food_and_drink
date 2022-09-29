require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:user){ FactoryBot.create(:user) }

  before do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "12345",
      info: {name: "asdasdasdsa",email: "asdsaadsaa@gmail.com"},
      password: Devise.friendly_token[0, 20]
    })
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "GET omniauth_callbacks#google_oauth2" do
    context "When user persited" do
      before do
        allow_any_instance_of(User).to receive(:persisted?).and_return(true)
        get :google_oauth2
      end

      it "should redirect to root_path" do
        response.should redirect_to root_path
      end
    end
    context "When user not exist" do
      before do
        allow_any_instance_of(User).to receive(:persisted?).and_return(false)
        get :google_oauth2
      end

      it "should redirect to new_user_registration_url" do
        response.should redirect_to new_user_registration_url
      end
    end
  end
end
