Rails.application.routes.draw do


  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations" ,
    sessions: 'public/sessions'
  }
  
  devise_for :admins, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  
  ## public
  
  # user 
  get 'users/:id/post' => "public/users#post_list", as: 'post_list'
  patch 'user/withdraw' => "public/users#withdraw", as: 'withdraw'
  get 'users/confirm' => "public/users#confirm", as: 'confirm'
  resources :users, only:[:show, :edit, :update, :destroy], module: 'public'
  

  # home
  
  root to: "public/homes#top"
  
  ## admin
  
  # user
   namespace :admin do
    resources :users, only:[:show, :index]
    get '/users/:id/post_list' => "users#post_list", as: 'admin_post_list'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
