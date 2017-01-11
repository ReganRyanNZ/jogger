require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  get "manager", to: "pages#manager"


  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do

  #   end
  # end

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :jogs, only: [:create, :show, :update, :destroy]
        resources :users, only: [:create, :show, :update, :destroy]
      end
    end
end
