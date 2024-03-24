class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    
    @user = User.find(params[:id])
    @posts = @user.posts.all
  
    
  end
  
  def withdraw
    @user = current_user
    @user.update(is_active: false)
    flash[:notice] = "退会を完了しました"
    reset_session
    redirect_to root_path
    
  end

  def edit
    
    
    @user = User.find(params[:id])
    
  end
  
  def update
    
    @user = User.find(params[:id])
    
    if @user.update(user_params)
     
    redirect_to user_path(@user)
      
    else
        
    render :edit
        
    end
  end  

  def post_list
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    
  end
  

  
  private
  
  def user_params
    
    params.require(:user).permit(:name, :introduction, :profile_image)
    
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
     redirect_to root_path
    end  
  end
  
    def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
    end  

end
