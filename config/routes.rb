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
  resources :users, only:[:show, :edit, :index], module: 'public'
  get 'users/confirm' => "public/users#confilm", as: 'confilm'
  
  
  ## admin
  
  # user
   namespace :admin do
    resources :users, only:[:show, :index]
    get '/users/:id/post_list' => "ausers#post_list", as: 'post_list'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
