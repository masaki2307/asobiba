class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    
    @user = User.find(params[:id])
    
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
  end

  def confirm
  end
  

  
  
  private
  
  def user_params
    
    params.require(:user).permit(:name, :introduction, :profile_image)
    
  end
end
