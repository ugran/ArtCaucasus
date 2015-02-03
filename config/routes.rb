Rails.application.routes.draw do

  resources :artists

  resources :items

  resources :itemimages

  resources :carts

#  resources :userinfos

  resources :comments

  resources :likes

  resources :orders

  resources :carousels

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	root "pages#home"
	get "paintings" => "pages#paintings"
	get "enamels" => "pages#enamels"
  get "textiles" => "pages#textiles"
  get "sculptures" => "pages#sculptures"
  get "channel" => "pages#channel"
  get "favorites" => "likes#index"
  get "FAQ" => "pages#faq"
  
end
