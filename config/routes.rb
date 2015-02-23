Rails.application.routes.draw do

  resources :artists, :path => "Authors"

  resources :items

  resources :itemimages

  resources :carts

#  resources :userinfos

  resources :comments

  resources :likes

  resources :orders

  resources :carousels

  resources :pricerequests

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	root "pages#home"
	get "paintings" => "pages#paintings"
	get "jewellery" => "pages#enamels", as: "enamels"
  get "textiles" => "pages#textiles"
  get "sculptures" => "pages#sculptures"
  get "channel" => "pages#channel"
  get "favorites" => "likes#index"
  get "AboutUs" => "pages#aboutus", as: "aboutus"
  get "Contact" => "pages#contact", as: "contact"
  get "MyFavorites" => "pages#favorites", as: "myfavorites"
  get "ordermanagement" => "pages#ordermanagement"
  get "requestmanagement" => "pages#requestmanagement"
  get 'sitemap.xml' => 'pages#sitemap', :defaults => { :format => 'xml' }

end
