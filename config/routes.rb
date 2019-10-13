Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
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

