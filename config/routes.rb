# frozen_string_literal: true

Rails.application.routes.draw do
  resource :users
  resources :games
  get '/leaderboard', to: 'users#index'
end
