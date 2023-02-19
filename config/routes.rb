# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    get '/charts', to: 'charts#index', as: :charts
  end
end
