Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#browse'

  resources :events
  get "events/:id/quit", to: "events#quit", as: "quit_event"
  # get "events/:id/movie/:movie_id", to: "events#movie_details", as: "movie_details"


  resources :watchlists, only: [:index, :show, :destroy]
  get "watchlists/:id/seen", to: "watchlists#mark_as_seen", as: "mark_as_seen"
  get "watchlists/:id/unsee", to: "watchlists#mark_as_not_seen", as: "mark_as_not_seen"

  resources :movies, only: [:browse, :show]
  post "movies/:id", to: "movies#create_and_add"
  delete "movies/:id", to: "movies#remove_from_watchlist"

  resources :users, only: [:index, :show] do
    resources :friendships, only: :create do
      collection do
        get 'accept_friend'
        get 'decline_friend'
        delete 'delete_pending'
        delete 'delete_friend'
      end
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
