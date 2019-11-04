Rails.application.routes.draw do 
  devise_for :users
  root 'products#index'
  resources :users, only: [:index,:edit] do
    collection do
      get :user_identification
    end
  end
  resources :products,only: [:index, :show, :new] do
    collection do
      get 'search'
    end
  end  
  resources :creditcards, only: [:index, :destroy]
  get 'logout' => "users#logout"
  get 'step1', to: 'registrations#step1'
  get 'step2', to: 'registrations#step2'
  get 'step3', to: 'registrations#step3'
  get 'step4', to: 'registrations#step4'
  get 'step5', to: 'registrations#step5'
  get 'step6', to: 'registrations#step6'
  get 'login', to: 'registrations#login'
  get 'buy', to: 'products#buy'
end
