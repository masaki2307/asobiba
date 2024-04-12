Rails.application.routes.draw do

  


  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations" ,
    sessions: 'public/sessions'
  }
  
  devise_for :admins, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
    devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    end
  ## public
  
  # user 
  get 'users' => "public/users#error" 
  get 'users/:id/post' => "public/users#post_list", as: 'post_list'
  patch 'user/withdraw' => "public/users#withdraw", as: 'withdraw'
  get 'users/confirm' => "public/users#confirm", as: 'confirm'
  resources :users, only:[:show, :edit, :update, :destroy], module: 'public'
  # post
  resources :posts, only:[:show, :edit, :index, :new, :create, :update, :destroy], module: 'public' do
  # comment
    resources :comments, only:[:create]
  end
  # favorite
   post 'favorite/:id' => 'public/favorites#create', as: 'create_favorite'
   delete 'favorite/:id' => 'public/favorites#destroy', as: 'destroy_favorite'
  # home
  
  root to: "public/homes#top"
  
  ## admin
  
  # user
   namespace :admin do
    resources :users, only:[:show, :update]
    get '/users/:id/post_list' => "users#post_list", as: 'post_list'
    end
  # post
    namespace :admin do
    resources :posts, only:[:show, :index, :destroy] do
        resources :comments, only:[:destroy]
    end
    end
  # genre
    namespace :admin do
      
    resources :genres, only:[:edit, :index, :create, :update]
    
    end
  # top
  get '/admin' => "admin/homes#top", as: 'admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
