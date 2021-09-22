Rails.application.routes.draw do


  devise_for :users
 root to: 'homes#top'
 get 'home/about',to: "homes#about"
 resources :users do
     resource :relationships, only: [:create, :destroy]
     get :followings, on: :member
     get :followers, on: :member
 end
 resources :books do
     resource :favorites, only: [:create, :destroy]
     resources :book_comments,only: [:create, :destroy]
 end
end
