Rails.application.routes.draw do
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
    get '/profile', to: "profile#show"
  end
  namespace :admin do
    resources :users, only: [:index]
  end
  resources :subscriptions
  resources :sessions
  resources :classrooms
  resources :categories
  resources :courses
end
