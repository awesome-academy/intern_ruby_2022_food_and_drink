require "rails_helper"
include AuthHelper

RSpec.describe Admin::OrdersController, type: :controller do
  let(:admin){ FactoryBot.create(:user, role: "admin") }
  let(:order){ FactoryBot.create :order }
  let(:order_pending){ FactoryBot.create :order, status: "pending" }
  let(:order_aprove){ FactoryBot.create :order, status: "approved" }
  let(:product){ FactoryBot.create :product }
  let(:order_details){ FactoryBot.create :order_details }
  before do
    sign_in :user, admin
  end

  describe "GET admin/orders#index" do
    it "render index page" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET admin/orders#edit" do
    before do
      allow(Order).to receive(:find).and_return(order)
    end

    it "render edit page" do
      get :edit, params:{
        id: order.id
      }
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "PATCH admin/orders#update" do
    context "with processing" do
      it "Update successfully" do
        patch :update, params:{
          id: order_aprove.id,
          order: {
            status: "processing"
          }
        }
        expect(response.body).to eq ""
      end

      it "Update fail" do
        expect { 
          patch :update, params:{
            id: order_aprove.id,
            order: {
              status: "rejected"
            }
          }
        }.to raise_error StandardError
      end
    end

    context "with approved" do
      it "Update successfully" do
        patch :update, params:{
          id: order_pending.id,
          order: {
            status: "approved"
          }
        }
        expect(response.body).to eq ""
      end

      it "Update fail" do
        expect { 
          patch :update, params:{
            id: order_pending.id,
            order: {
              status: "processing"
            }
          }
        }.to raise_error StandardError
      end
    end

    context "with fail" do
      it "Update fail" do
        expect { patch :update, params:{
            id: order_pending.id,
            order: {
              status: ""
            }
          }
        }.to raise_error StandardError
      end

      it "Run update fail" do
        expect { patch :update, params:{
            id: order_pending.id,
            order: {
              status: "approved"
            }
          }
        }.to raise_error StandardError
      end
    end
  end
end
