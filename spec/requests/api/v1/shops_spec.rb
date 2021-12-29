require 'rails_helper'

RSpec.describe "Api::V1::Shops", type: :request do
  before do
    @app = create(:application)
    customer = create(:user_customer)
    @region = create(:region)
    @shop = create(:shop, region: @region)

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

    context 'List Shops' do
    it 'Success' do

      params = { 
          access_token: @customer_access_token,
          page: 1, 
          per_page: 10
      }
      
      get api_v1_shops_url, params: params, as: :json
      
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end

    it 'Failed: wrong request' do
      params = { 
          access_token: "wrong access token",
          page: 1, 
          per_page: 10
      }

      get api_v1_shops_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).not_to eq(200) 
    end
  end
end
