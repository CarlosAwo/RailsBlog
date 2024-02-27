Rails.application.routes.draw do
  scope module: 'web' do
    resource :registrations
    resource :password, only: [:edit, :update], controller: 'password'
    resource :password_reset, only: [:new, :create, :edit, :update], controller: 'password_reset'
    resource :confirmations, only: [:new, :create] do 
      collection do
        get 'confirm'
      end
    end
    resource :sessions
    resources :subscribers, only: [:new, :create] do 
      collection do
        get 'confirm'
      end
    end
    root 'home#home'
    resources :articles do 
      resources :likes, only: [:create] do
        collection do 
          delete :destroy
        end
      end
      resource :comments
    end

    # error pages
    %w[404 422 500 503].each do |code|
      get code, to: 'errors#show', code: code
    end
  end
  
  namespace :api do
    namespace :v1 do
      resource :sessions, only: [:create, :destroy]
      resources :articles, only: [:index]
    end
  end
  
  # root "articles#index"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

