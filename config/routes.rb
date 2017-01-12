require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get "manager", to: "pages#manager"


  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :jogs, only: [:create, :show, :update, :destroy]
        resources :users, only: [:create, :show, :update, :destroy]
      end
    end
end
