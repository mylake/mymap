Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :places
    end
  end
end
