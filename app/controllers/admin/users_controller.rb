class Admin::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to admin_user_path
    else
      render :show
    end  
  end

  def post_list
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @user = User.find(params[:id])
    if @start_date && @end_date
      @posts = @user.posts.where(created_at: @start_date..@end_date).page(params[:page])  
    else   
      @posts = @user.posts.page(params[:page])
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:is_active)
  end
end
