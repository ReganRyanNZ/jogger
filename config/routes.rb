require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  resources :jogs
  resources :users, only: [:destroy, :edit, :update]
  get "new_date_filter", to: "jogs#new_date_filter"
  post "filter_dates", to: "jogs#filter_dates"
  root to: "pages#home"
  get "manager", to: "pages#manager"
  get "report", to: "pages#report"

  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/'  do
      scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
        resources :jogs, only: [:create, :show, :update, :destroy]
        resources :users, only: [:create, :show, :update, :destroy]
        resources :sessions, only: [:create, :destroy]
      end
    end
end
