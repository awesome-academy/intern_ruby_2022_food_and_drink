require "rails_helper"

RSpec.describe DashboardController, type: :controller do
  let(:product){ FactoryBot.create :product }
  let(:category){ FactoryBot.create :category }
  let(:size){ FactoryBot.create :size }

  describe "GET admin/dashboard#index" do
    it "render index page" do
      get :index
      expect(response).to render_template("pages/products_landing")
    end
  end

  describe "GET admin/dashboard#show" do
    context "show successfully" do
      it "render show page" do
        get :show, params:{
          id: product.id
        }
        expect(response).to render_template("pages/show")
      end
    end

    context "show failed" do
      before do
        get :show, params:{
          id: ""
        }
      end

      it do
        expect(response.status).to eq 404
      end
    end
  end
end
