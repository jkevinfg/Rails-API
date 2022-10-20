Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/health', to: 'health#health' #to: controller#method 

  resources :posts, only: [:index, :show, :create, :update]
  get '/posts_user', to: 'posts#posts_user'

end
