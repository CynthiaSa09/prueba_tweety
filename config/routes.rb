Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  resources :tweets do 
    post 'like', to: 'tweets#like'
    member do
      post 'create_rt'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
  root to: "tweets#index"
  get '/tweets/hashtag/:name', to:'tweets#hashtags'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end