Rails.application.routes.draw do
  root "registrations#login"
  root 'products#index'
end
