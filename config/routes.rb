Rails.application.routes.draw do
  root 'home#index'

  resources :games
  post '/games/:id/bot_buzzed', to: 'games#bot_buzzed'
end
