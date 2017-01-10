Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  get "manager", to: "pages#manager"


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :jogs, only: [:create, :show, :update, :destroy]
      resources :users, only: [:create, :show, :update, :destroy]
    end
  end
end
