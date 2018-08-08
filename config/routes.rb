Rails.application.routes.draw do
  resources :whatspp_messages, only: [:create]
  resources :users, only: [:show, :new, :create, :update, :edit] do 
  	resources :whatspp_messages, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
