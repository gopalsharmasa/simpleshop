require 'factory_bot'

RSpec.configure do |config|
    # FactoryBot.reload
    FactoryBot.factories.clear
    config.include FactoryBot::Syntax::Methods
    FactoryBot.find_definitions
end