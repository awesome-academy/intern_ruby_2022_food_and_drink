require "rails_helper"
include AuthHelper

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin){ FactoryBot.create(:user, role: "admin") }
  before do
    sign_in :user, admin
  end

  describe "GET admin/users#index" do
    it "render index page" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
