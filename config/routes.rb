Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/:year/makes', to: 'cars#makes'
    end
  end
end
