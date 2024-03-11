Rails.application.routes.draw do

  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'homes/top'
  end
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations" ,
    sessions: 'public/sessions'
  }
  
  devise_for :admins, skip: [:passwords, :registrations], controllers: {
    sessions: "admin/sessions"
  }
  
  ## public
  
  # user 
  resources :users, only:[:show, :edit, :update, :destroy], module: 'public'
  get 'users/confirm' => "public/users#confilm", as: 'confilm'
  get 'users/:id/post' => "public/users#post_list", as: 'post_list'
  
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
