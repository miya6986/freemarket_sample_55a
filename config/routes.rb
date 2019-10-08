Rails.application.routes.draw do
  root "users#index"
  get "users/index2" => "users#index2"
end
