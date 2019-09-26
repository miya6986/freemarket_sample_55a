Rails.application.routes.draw do
  get 'products/index'
  root 'top#index'
end
