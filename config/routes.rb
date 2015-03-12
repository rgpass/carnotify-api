Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/makes', to: 'cars#makes'
      get '/maintenance', to: 'cars#maintenance'
      resources :users
      resources :sessions, only: [:create, :index]
      delete '/signout', to: 'sessions#destroy'
    end
  end
end
