Rails.application.routes.draw do
  root "users#index"
  get 'logout' => "users#logout"
end
