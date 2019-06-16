# frozen_string_literal: true

Rails.application.routes.draw do
  get 'new', to: 'games#new', as: 'create_game'
  get 'score', to: 'games#score', as: 'view_score'
  post 'score', to: 'games#score', as: 'add_score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
