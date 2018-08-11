Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', sessions: "sessions"}
  devise_scope :user do
    post 'users/pre_otp', to: 'sessions#pre_otp'
    root to: 'users#show'
  end
	
  resources :whatspp_messages, only: [:create, :show]
  resources :users, only: [:show] do
  	member do
		  post 'events_count'
		  post 'event_data_by_category_and_minute'
      post 'events_by_category_data'
		end
  	resources :whatspp_messages, only: [:index]
  end
  resource :two_factor
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end