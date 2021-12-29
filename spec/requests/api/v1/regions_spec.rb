require 'rails_helper'

RSpec.describe "Api::V1::RegionsController", type: :request do
  before do
    @app = create(:application)
    customer = create(:user_customer)
    admin = create(:user_admin)
    @region = create(:region)

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

  context 'List Regions' do
    it 'Success' do

      params = { 
          access_token: @customer_access_token,
          page: 1, 
          per_page: 10
      }
      
      get api_v1_regions_url, params: params, as: :json
      
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end

    it 'Failed: wrong request' do
      params = { 
          access_token: "wrong access token",
          page: 1, 
          per_page: 10
      }

      get api_v1_regions_url, params: params, as: :json

      data = JSON.parse(response.body)
      expect(data["code"]).not_to eq(200) 
    end
  end

  context 'Create Region' do

    it 'Failed: Customer can not create regions' do
      params = { 
          access_token: @customer_access_token,
          region: {
            title: "South",
            country: "USA",
            currency: "USD",
            tax: 10
          }
      }
      
      post api_v1_regions_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(422) 
    end

    it 'Failed: Params Missing' do

      params = { 
          access_token: @admin_access_token,
          region: {
            title: nil,
            country: nil,
            currency: nil,
            tax: 0
          }
      }
      
      post api_v1_regions_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end

    it 'Success: Admin can create regions' do
      params = { 
          access_token: @admin_access_token,
          region: {
            title: "South",
            country: "USA",
            currency: "USD",
            tax: 10
          }
      }
      
      post api_v1_regions_url, params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end

  context 'Update Region' do

    it 'Failed: Customer can not update region' do
      params = { 
          access_token: @customer_access_token,
          region: {
            title: "South",
            country: "USA",
            currency: "USD",
            tax: 10
          }
      }
      
      put api_v1_region_url(@region.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(422) 
    end

    it 'Failed: Params Missing' do

      params = { 
          access_token: @admin_access_token,
          region: {
            title: nil,
            country: nil,
            currency: nil,
            tax: 0
          }
      }
      
      put api_v1_region_url(@region.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(401) 
    end

    it 'Success: Admin can update region' do
      params = { 
          access_token: @admin_access_token,
          region: {
            title: "South",
            country: "USA",
            currency: "USD",
            tax: 10
          }
      }
      
      put api_v1_region_url(@region.id), params: params, as: :json
      data = JSON.parse(response.body)
      expect(data["code"]).to eq(200) 
    end
  end

end
