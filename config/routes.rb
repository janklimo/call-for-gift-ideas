Rails.application.routes.draw do
  root to: 'pages#landing'
  resources :calls, only: [:show, :create, :update]
end
