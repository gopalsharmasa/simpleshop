require 'rails_helper'

RSpec.describe "Api::V1::PaymentsController", type: :request do
  before do
    @app = create(:application)
    customer = create(:user_customer)
    @region = create(:region)
    @shop = create(:shop, region: @region)
    @product = create(:product, shop: @shop)
    @product1 = create(:product, shop: @shop)
    @order = create(:order, user: customer)
    @order_item = create(:order_item, order: @order, product: @product, quantity: 2)
    @order_item2 = create(:order_item, order: @order, product: @product1, quantity: 3)

    @payment = create(:fake_payment, order: @order, user: customer, amount: @order.order_total)
    @payment1 = create(:fake_payment, order: @order, user: customer, amount: @order.order_total)
    
    # Customer login
    params = { 
          client_id: @app.uid, 
          grant_type: "password", 
          email: "customer@example.com", 
          password: "123456"
    }

    post oauth_token_url, params: params, as: :json
    data = JSON.parse(response.body)
    @customer_access_token = data["access_token"]
  end

  context 'Initiate Order Payment' do

    it 'Failed: Invalid access token' do
      params = { 
          access_token: "invalid access token"
      }
      
      post api_v1_order_payments_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(400) 
    end

    it 'Success: Payment initiated' do
      params = { 
          access_token: @customer_access_token
      }
      
      post api_v1_order_payments_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end

  context 'Update Payment Status' do

    it 'Failed Payment' do
      params = { 
          access_token: @customer_access_token,
          status: "failed"
      }
      
      put api_v1_order_payment_url(@order.id, @payment.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200)
    end

    it 'Success Payment' do
      params = { 
          access_token: @customer_access_token,
          status: "success"
      }
      
      put api_v1_order_payment_url(@order.id, @payment1.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200)
    end
  end
end
