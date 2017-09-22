Rails.application.routes.draw do
  namespace :admin do
    resources :products
    resources :calls

    root to: "products#index"
  end

  root to: 'pages#landing'
  resources :calls, only: [:show, :create, :update]
end
