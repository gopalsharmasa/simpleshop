require 'rails_helper'

RSpec.describe "Api::V1::Registrations", type: :request do
  describe "Registrations & Login Authentications" do
    context 'Register customer' do
      it 'signup success' do
        app = create(:application)

        params = { 
              client_id: app.uid,
              registration: {
                email: "customer@example.com",
                password: "123456"
              }
        }

        # get oauth_token_url, as: :json
        post api_v1_registrations_url, params: params, as: :json

        data = JSON.parse(response.body)

        expect(data["code"]).to eq(201) 
      end

      it 'Signup failed, with existing email id' do
        app = create(:application)
        user = create(:user_customer)

        params = {
          client_id: app.uid,
          registration: {
            email: "customer@example.com",
            password: "123456"
          }
        }

        # get oauth_token_url, as: :json
        post api_v1_registrations_url, params: params, as: :json

        data = JSON.parse(response.body)

        expect(data["code"]).not_to eq(201) 
      end
    end

    context 'Signin customer' do
      it 'login success' do
        app = create(:application)
        user = create(:user_customer)

        params = { 
              client_id: app.uid, 
              grant_type: "password", 
              email: "customer@example.com", 
              password: "123456"
        }

        # get oauth_token_url, as: :json
        post oauth_token_url, params: params, as: :json

        data = JSON.parse(response.body)
        expect(data["access_token"]).not_to eq(nil) 
      end

      it 'login failed' do
        app = create(:application)
        user = create(:user_customer)

        params = { 
              client_id: app.uid, 
              grant_type: "password", 
              email: "customer@example.com", 
              password: "1234568"
        }

        # get oauth_token_url, as: :json
        post oauth_token_url, params: params, as: :json

        data = JSON.parse(response.body)
        expect(data["access_token"]).to eq(nil) 
      end
    end
  end
end
