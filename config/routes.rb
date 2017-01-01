Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :campuses do
        collection do
          get :search
        end
      end
    end
  end
end
