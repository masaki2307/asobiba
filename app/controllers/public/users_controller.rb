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
    reset_session
    flash[:notice] = "退会を完了しました"
    redirect_to root_path
    
  end

  def edit
    @user = User.find(params[:id])
   
  end
  
  def update
    
    @user = User.find(params[:id])
    @user.like_genre = Genre.find_by(name: params[:user][:like_genre])
    
    if @user.update(user_params)
    flash[:notice] = "ユーザー情報を更新しました" 
    redirect_to user_path(@user)
      
    else
        
    render :edit
        
    end
    
  end  
  
  def error
    redirect_to new_user_registration_path
  end  

  def post_list
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @user = User.find(params[:id])
    if params[:sort_created].present?  
      @posts = @user.posts.order(created_at: :desc).page(params[:page]) 
    elsif params[:sort_review].present?  
      # @posts = Post.where(id: Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id)).page(params[:page]) 
      posts_arr = @user.posts.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
      @posts = Kaminari.paginate_array(posts_arr).page(params[:page])
    elsif @start_date && @end_date
      @posts = @user.posts.where(created_at: @start_date..@end_date).page(params[:page]) 
    else  
      @posts = @user.posts.page(params[:page])
    end
  end
  

  
  private
  
  def user_params
    
    params.require(:user).permit(:name, :introduction, :profile_image, :like_genre)
    
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
