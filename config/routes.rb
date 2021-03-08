Rails.application.routes.draw do

  resources :sessions
  resources :classrooms
  resources :categories
  resources :courses
  resources :users do
    resources :subscriptions
  end

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
      get '/profile', to: "profile#show"
  end
end
