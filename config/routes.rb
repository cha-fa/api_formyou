Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  namespace :api, defaults: { format: :json } do
    get "/profile", to: "profile#show"
    patch "/profile", to: "profile#update"
  end
  namespace :admin do
    resources :users, only: [:index, :update, :destroy]
  end

  resources :promotions
  resources :classrooms
  resources :categories
  resources :courses
  resources :users, only: [:show] do
    resources :subscriptions
  end


end
