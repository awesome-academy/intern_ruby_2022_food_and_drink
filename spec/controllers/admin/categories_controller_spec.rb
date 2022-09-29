require "rails_helper"
include AuthHelper

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin){ FactoryBot.create(:user, role: "admin") }
  let!(:category){ FactoryBot.create :category }
  let!(:category_1){ FactoryBot.create :category }
  let!(:product){ FactoryBot.create :product, category_id: category_1.id }
  let!(:product_attribute){ FactoryBot.create :product_attribute, product_id: product.id }
  let!(:order_details){ FactoryBot.create :order_detail, product_attribute_id: product_attribute.id }
  before do
    sign_in :user, admin
  end

  describe "GET admin/categories#index" do
    it "render index page" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET admin/categories#new" do
    it "render new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST admin/categories#create" do
    context "with valid attributes" do
      before do
        post :create, params:{category: {name: "abc"}}
      end

      it "should create new product" do
        change{Category.count}.by 1
      end

      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("admin.categories.create.alert_success_create")
      end

      it "should create new product reponse" do
        expect(response).to redirect_to admin_categories_path
      end
    end

    context "with invalid attributes" do
      before do
        post :create,params:{category: {name: ""}}
      end

      it "does not save new product" do
        change{Category.count}.by 0
      end

      it "Create failed and show flash" do
        expect(flash[:danger]).to eq I18n.t("admin.categories.create.alert_err_create")
      end

      it "Create failed and render new view" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET admin/categories#edit" do
    before do
      allow(Category).to receive(:find).and_return(category)
    end

    it "render edit page" do
      get :edit, params:{
        id: category.id
      }
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "PATCH admin/categories#update" do
    before do
      allow(Category).to receive(:find).and_return(category)
    end

    context "with invalid attributes" do
      before do
        patch :update, params:{
          id: category.id,
          category: {
            name: category.name
          }
        }
      end

      it "Update successfully and show flash" do
        expect(flash[:success]).to eq I18n.t("admin.categories.update.alert_success_update")
      end

      it "Update successfully and redirect page" do
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context "with invalid attributes" do
      before do
        patch :update, params:{
          id: category.id,
          category: {
            name: ""
          }
        }
      end

      it "Update failed and show flash" do
        expect(flash[:danger]).to eq I18n.t("admin.categories.update.alert_err_update")
      end

      it "Update failed and render edit view" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE admin/categories#destroy without exception" do
    before do
      allow(Category).to receive(:find).and_return(category)
    end

    context "When delete successful" do
      before do
        allow(category).to receive(:destroy).and_return(true)
      end

      it do
        delete :destroy, params: { 
          id: category.id 
        }
        response.header["Content-Type"].should include "application/json"
        expect(response.body).to match(
          {
            :message => I18n.t("admin.categories.destroy.alert_success_destroy"),
            :status => 200
          }.to_json
        )
      end
    end

    context "When delete fail" do
      before do
        allow(category).to receive(:destroy).and_return(false)
      end

      it do
        delete :destroy, params: { 
          id: category.id 
        }
        response.header["Content-Type"].should include "application/json"
        expect(response.body).to match(
          {
            :message => I18n.t("admin.categories.destroy.alert_err_destroy"),
            :status => 500
          }.to_json
        )
      end
    end
  end

  describe "DELETE admin/categories#destroy with exception" do
    before do
      allow(Category).to receive(:find).and_return(category_1)
    end

    context "When raise exception" do
      it do
        expect { delete :destroy, params: { 
            id: category_1.id 
          } 
        }.to raise_error StandardError
      end
    end
  end
end
