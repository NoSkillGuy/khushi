Rails.application.routes.draw do
	root to: "user#index"
  resources :whatspp_messages, only: [:create, :show]
  resources :users, only: [:show, :new, :create, :update, :edit, :index] do
  	resources :events, only: [:index]
  	resources :whatspp_messages, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
