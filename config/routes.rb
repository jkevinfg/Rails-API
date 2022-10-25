Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/posts/unpublished', to: 'posts#unpublished_posts'
  resources :posts, only: [:index, :show, :create, :update]
end
