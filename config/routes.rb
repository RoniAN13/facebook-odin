Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: %i[create destroy]
    member do
      put "like" => "posts#upvote"
      put "dislike" => "posts#downvote"
    end
  end 
  get 'static_pages/home'
  
 
  devise_for :users
  resources :users do
   member do
    get :friends
    end
  end
  resources :friend_requests
root "static_pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
