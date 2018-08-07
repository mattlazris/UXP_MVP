Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :experiences do
    get "host", to: "pages#host"
    resources :bookings
  end

  get "profile", to: "pages#profile", as: "profile"
end
