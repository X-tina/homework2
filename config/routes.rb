Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome#show'
  
  resources :movies do
    put 'publish', on: :member
  end

end
