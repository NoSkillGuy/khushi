Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
	root 'users#show'
  resources :whatspp_messages, only: [:create, :show]
  resources :users, only: [:show] do
  	member do
		  post 'events_count'
		  post 'events_data'
		end
  	resources :whatspp_messages, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end