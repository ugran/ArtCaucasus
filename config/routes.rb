Rails.application.routes.draw do

  resources :artists

  resources :items

  resources :itemimages

  resources :carts

  resources :userinfos

  resources :comments

  resources :likes

  devise_for :users

	root "pages#home"
	get "paintings" => "pages#paintings"
	get "enamels" => "pages#enamels"
  
end
