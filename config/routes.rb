Rails.application.routes.draw do

  resources :artists

  resources :items

  resources :itemimages

  resources :carts

  devise_for :users

	root "pages#home"

end
