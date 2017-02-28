Rails.application.routes.draw do
  get 'braintree/new'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  post 'braintree/checkout'

  resources :listings, only: [:index] do
    resources :tags
  end

  resources :users do
    resources :listings
  end

  resources :listings do 
    resources :reservations, only: [:new, :create, :index]

  end

  resources :users, only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints Clearance::Constraints::SignedIn.new do
  root :to => 'users#index', as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
  root to: 'clearance/sessions#new'
  end

end
