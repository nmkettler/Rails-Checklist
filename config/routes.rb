Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
	end
	devise_for :models

	resources :items do
	  member do
	    patch :complete
	  end
	end
 root 'items#index'
end
