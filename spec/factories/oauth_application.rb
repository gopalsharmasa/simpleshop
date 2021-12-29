FactoryBot.define do
  factory :oauth_application, class: "Doorkeeper::OAuthAapplications" do
    sequence(:name) { |n| "Project #{n}" }
    sequence(:redirect_uri)  { |n| "https://example#{n}.com" }
  end
end