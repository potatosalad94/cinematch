Rails.application.routes.draw do
  get 'friendships/create'
  devise_for :users
  root to: 'movies#browse'

  resources :watchlists, only: [:index, :show, :destroy]
  resources :users, only: %i[index show] do
    resources :friendships, only: %i[create]
  end

  resources :movies, only: [:browse, :show]
  post "movies/:id", to: "movies#create_and_add"
  delete "movies/:id", to: "movies#remove_from_watchlist"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
