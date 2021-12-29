require 'rails_helper'

RSpec.describe "Api::V1::OrdersController", type: :request do
  before do
    @app = create(:application)
    customer = create(:user_customer)
    admin = create(:user_admin)
    @order = create(:order, user: customer)

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

    # Admin login
     params = { 
          client_id: @app.uid, 
          grant_type: "password", 
          email: "admin@example.com", 
          password: "123456"
    }

    post oauth_token_url, params: params, as: :json
    data = JSON.parse(response.body)
    @admin_access_token = data["access_token"]
  end

  context 'Orders List' do
    it 'Success' do
      params = { 
          access_token: @customer_access_token,
          page: 1, 
          per_page: 10
      }
      
      get api_v1_orders_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end

    it 'Failed: wrong request' do
      params = { 
          access_token: "wrong access token",
          page: 1, 
          per_page: 10
      }

      get api_v1_orders_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).not_to eq(200) 
    end
  end

  context 'Create Order' do

    it 'Failed: Params Missing' do
      params = { 
          access_token: @customer_access_token,
          order: {
              customer_name: nil,
              shipping_address: nil
            }
      }
      
      post api_v1_orders_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end

    it 'Success: Customer can create order' do
      params = { 
          access_token: @customer_access_token,
          order: {
              customer_name: "Test User",
              shipping_address: "Test Address, City"
            }
      }
      
      post api_v1_orders_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end

  context 'Update Order' do

    it 'Failed: Customer can not update another customer order' do
      params = { 
          access_token: @admin_access_token,
          order: {
              customer_name: "Test User",
              shipping_address: "Test Address, City"
            }
      }
      put api_v1_order_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(404) 
    end

    it 'Failed: Params Missing' do

      params = { 
          access_token: @customer_access_token,
          order: {
              customer_name: nil,
              shipping_address: nil
            }
      }

      put api_v1_order_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end

    it 'Success: customer can update his order' do
      params = { 
          access_token: @customer_access_token,
          order: {
              customer_name: "Test User",
              shipping_address: "Test Address, City"
            }
      }
      
      put api_v1_order_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end
end