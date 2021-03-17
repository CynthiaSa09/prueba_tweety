Rails.application.routes.draw do

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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end