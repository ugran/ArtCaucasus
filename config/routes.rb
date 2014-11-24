Rails.application.routes.draw do

  resources :artists

  resources :items

  devise_for :users
	root "pages#home"
	
end
