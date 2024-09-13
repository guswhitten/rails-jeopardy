Rails.application.routes.draw do
  get 'static_pages/privacy'
  root 'home#index'

  resources :games
  post '/games/:id/bot_buzzed', to: 'games#bot_buzzed'
  get 'privacy', to: 'static_pages#privacy'
  get 'game_over', to: 'static_pages#game_over'
end
