require 'rails_helper'

RSpec.describe "Api::V1::ProductsController", type: :request do
  before do
    @app = create(:application)
    customer = create(:user_customer)
    admin = create(:user_admin)
    @region = create(:region)
    @shop = create(:shop, region: @region)
    @product = create(:product, shop: @shop)

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

  context 'Products List' do
    it 'Success' do

      params = { 
          access_token: @customer_access_token,
          page: 1, 
          per_page: 10
      }
      
      get api_v1_shop_products_url(@shop.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end

    it 'Failed: wrong request' do
      params = { 
          access_token: "wrong access token",
          page: 1, 
          per_page: 10
      }

      get api_v1_shop_products_url(@shop.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).not_to eq(200) 
    end
  end

  context 'Create Product' do

    it 'Failed: Customer can not create products' do
      params = { 
          access_token: @customer_access_token,
          product: {
            title: "This is test product",
            description: "This is test describe",
            price: 5.5,
            sku: "number",
            stock: 10,
            shop: @shop.id
          }
      }
            
      post api_v1_shop_products_url(@shop.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(422) 
    end

    it 'Failed: Params Missing' do

      params = { 
          access_token: @admin_access_token,
          product: {
            title: nil,
            description: nil,
            price: nil,
            sku: nil,
            stock: nil,
            shop: @shop.id
          }
      }
      
      post api_v1_shop_products_url(@shop.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end

    it 'Success: Admin can create products' do
      params = { 
          access_token: @admin_access_token,
          product: {
            title: "This is test product",
            description: "This is test describe",
            price: 5.5,
            sku: "number",
            stock: 10,
            shop: @shop.id
          }
      }
      
      post api_v1_shop_products_url(@shop.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end

  context 'Update Product' do

    it 'Failed: Customer can not update product' do
      params = { 
          access_token: @customer_access_token,
          product: {
            title: "This is test product",
            description: "This is test describe",
            price: 5.5,
            sku: "number",
            stock: 10,
            shop: @shop.id
          }
      }
            
      put api_v1_shop_product_url(@shop.id, @product.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(422) 
    end

    it 'Failed: Params Missing' do

      params = { 
          access_token: @admin_access_token,
          product: {
            title: nil,
            description: nil,
            price: nil,
            sku: nil,
            stock: nil,
            shop: @shop.id
          }
      }
      
      put api_v1_shop_product_url(@shop.id, @product.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end

    it 'Success: Admin can create products' do
      params = { 
          access_token: @admin_access_token,
          product: {
            title: "This is test product",
            description: "This is test describe",
            price: 5.5,
            sku: "number",
            stock: 10,
            shop: @shop.id
          }
      }
      
      put api_v1_shop_product_url(@shop.id, @product.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end
end
