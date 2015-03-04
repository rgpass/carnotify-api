Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/makes/:year', to: 'cars#makes'
      get '/maintenance/:modelyearid', to: 'cars#maintenance'
    end
  end
end
