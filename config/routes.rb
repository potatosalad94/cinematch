Rails.application.routes.draw do
  # get 'watchlists/create'
  devise_for :users
  root to: 'movies#browse'

  resources :movies, only: [:browse, :show]
  post "movies/:id", to: "movies#add_to_watchlist"

  resources :watchlists, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
