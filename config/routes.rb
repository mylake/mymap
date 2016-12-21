Rails.application.routes.draw do
  devise_for :users
  root :to => 'welcome#show'
  load Rails.root.join('config/routes/api_v1.rb')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
