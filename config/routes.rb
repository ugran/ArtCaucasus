Rails.application.routes.draw do

  resources :artists

  resources :items

  resources :itemimages

  resources :carts

  resources :userinfos

  devise_for :users

	root "pages#home"
	get "test" => "pages#test"

end
