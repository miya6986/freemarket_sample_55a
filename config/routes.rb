Rails.application.routes.draw do 
  devise_for :users,
             controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root 'products#index'
  get 'auth/failure', to: 'omniauth_callbacks#failure'

  resources :users, only: [:index, :edit, :update] do
    collection do
      get :identification
      get :my_selling_products
      get :logout_page
    end
    member do
      patch :edit
    end
  end
  
  resources :creditcards, only: [:index, :new, :create, :destroy]

  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
      get 'get_size', defaults: { format: 'json' }
    end
    member do
      get :item
      get :buy
    end
  end 

  resources :categories, only: [:index, :show]
  resources :brand, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :creditcards, only: [:index, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  
  get 'login', to: 'registrations#login'
  
  resources :registrations do
    collection do
      get  'step1'
      get  'step2'
      get  'step3'
      get  'step4'
      get  'step5'
      get  'step6'
    end
  end
end


