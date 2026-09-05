Rails.application.routes.draw do
  devise_for :users

  resources :items, only: [:index, :show, :new, :create, :edit]

  root "items#index"
end
