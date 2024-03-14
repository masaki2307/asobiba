class Admin::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path
    else
      render :show
    end  
  end

  def post_list
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:is_active)
  end
end
