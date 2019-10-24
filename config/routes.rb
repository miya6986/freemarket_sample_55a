Rails.application.routes.draw do 
  devise_for :users
  root 'products#index'
  resources :users, only: [:index,:edit] do
    collection do
      get :user_identification
    end
  end
  resources :products,only: [:index, :show, :new]
  resources :creditcards, only: [:index, :destroy]
  get 'logout' => "users#logout"
  get 'step1', to: 'registrations#step1'
  get 'login', to: 'registrations#login'
  get 'buy', to: 'products#buy'
  
  resources :users,only: 'index'
  resources :registrations do
    collection do
      get  'step2'
      get  'step3'
      get  'step4'
      get  'step5'
      get 'step6'
    end
  end
end

