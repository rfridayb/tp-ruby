Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post("sign_up", to: "users#create")
  get("sign_up", to: "users#new")
  
  resources(:confirmations, only: [:create, :edit, :new], param: :confirmation_token)
  resources(:passwords, only: [:create,:edit,:new,:update],param: :password_reset_token)
  resources(:active_sessions, only: [:destroy]) do
    collection do
      delete("destroy_all")
    end
  end
  resources(:tweets, except: [:edit,:update])

  post("login", to: "sessions#create")
  delete("logout", to: "sessions#destroy")
  get("login", to: "sessions#new")

  put("account", to: "users#update")
  get("account", to: "users#edit")
  delete("account", to: "users#destroy")
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get("up" => "rails/health#show", as: :rails_health_check)

  # Defines the root path route ("/")
  # root "posts#index"
  root('home#index')
end
