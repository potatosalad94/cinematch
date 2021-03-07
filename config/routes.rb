Rails.application.routes.draw do
  devise_for :users
  root to: 'movies#browse'

  resources :watchlists, only: [:index, :show, :destroy]

  resources :movies, only: [:browse, :show]
  post "movies/:id", to: "movies#create_and_add"
  delete "movies/:id", to: "movies#remove_from_watchlist"

  resources :users, only: [:index, :show] do
    resources :friendships, only: :create do
      collection do
        get 'accept_friend'
        get 'decline_friend'
        delete 'delete_pending'
      end
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
