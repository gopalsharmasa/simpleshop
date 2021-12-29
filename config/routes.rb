Rails.application.routes.draw do
 
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]

      resources :regions, only: [:create, :update, :index]
      resources :shops, only: [:create, :update, :index] do 
        resources :products, only: [:create, :update, :index, :show]
      end

      resources :orders, except: [:edit, :new] do 
        resources :order_items, except: [:edit, :new, :show]
        resources :payments, only: [:create, :update]
      end
    end
  end

end
