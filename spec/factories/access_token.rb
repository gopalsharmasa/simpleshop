FactoryBot.define do
  factory :application, class: "Doorkeeper::Application" do 
    name { "Android client" }
    scopes { "read write" }
    confidential { false }
    redirect_uri { "urn:ietf:wg:oauth:2.0:oob" }
  end

  factory :access_token, class: "Doorkeeper::AccessToken" do
    application
    expires_in { 2.hours }
    scopes { "public" }
  end


end
