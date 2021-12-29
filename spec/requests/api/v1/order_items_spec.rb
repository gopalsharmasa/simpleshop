require 'rails_helper'

RSpec.describe "Api::V1::OrderItemsController", type: :request do
  before do
    @app = create(:application)
    customer = create(:user_customer)
    admin = create(:user_admin)
    @region = create(:region)
    @shop = create(:shop, region: @region)
    @product = create(:product, shop: @shop)
    @product1 = create(:product, shop: @shop)
    @order = create(:order, user: customer)
    @order_item = create(:order_item, order: @order, product: @product, quantity: 2)

    @order2 = create(:order, user: admin)
    @order_item2 = create(:order_item, order: @order2, product: @product, quantity: 2)

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

  context 'Order Items List' do
    it 'Success' do
      params = { 
          access_token: @customer_access_token,
          page: 1, 
          per_page: 10
      }
      
      get api_v1_order_order_items_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end

    it 'Failed: get another user order items list' do
      params = { 
          access_token: @customer_access_token,
          page: 1, 
          per_page: 10
      }

      get api_v1_order_order_items_url(@order2.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).not_to eq(200) 
    end

    it 'Failed: wrong request' do
      params = { 
          access_token: "wrong access token",
          page: 1, 
          per_page: 10
      }

      get api_v1_order_order_items_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).not_to eq(200) 
    end
  end

  context 'Create Order Item' do

    it 'Failed: Params Missing' do
      params = { 
          access_token: @customer_access_token,
          order_item: {
              product_id: nil,
              quantity: nil
            }
      }
      
      post api_v1_order_order_items_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(404) 
    end

    it 'Failed: Quantity blank' do
      params = { 
          access_token: @customer_access_token,
          order_item: {
              product_id: @product.id,
              quantity: nil
            }
      }
      
      post api_v1_order_order_items_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end
    

    it 'Success: Order item added' do
      params = { 
          access_token: @customer_access_token,
          order_item: {
              product_id: @product1.id,
              quantity: 3
            }
      }
      
      post api_v1_order_order_items_url(@order.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end

  context 'Update Order Item' do

    it 'Failed: Params Missing' do
      params = { 
          access_token: @customer_access_token,
          order_item: {
              product_id: nil,
              quantity: nil
            }
      }
      
      put api_v1_order_order_item_url(@order.id, @order_item.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(404) 
    end

    it 'Failed: Quantity blank' do
      params = { 
          access_token: @customer_access_token,
          order_item: {
              product_id: @product.id,
              quantity: nil
            }
      }
      
      put api_v1_order_order_item_url(@order.id, @order_item.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end
    
    it 'Success: Order item updated' do
      params = { 
          access_token: @customer_access_token,
          order_item: {
              product_id: @product.id,
              quantity: 3
            }
      }
      
      put api_v1_order_order_item_url(@order.id, @order_item.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end

  end
end