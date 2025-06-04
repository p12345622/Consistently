Rails.application.routes.draw do
  get 'dashboard/index'
  devise_for :users

  resources :habits do
    member do
      post :check_in
    end
  end

  root 'dashboard#index'
end
