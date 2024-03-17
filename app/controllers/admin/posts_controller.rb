class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:search].present?
      @posts = Post.joins(:user).where("title LIKE (?) OR users.name LIKE (?)", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]) 
    elsif params[:genre_name].present?
      @genre = Genre.find_by(name: params[:genre_name])
      @posts = @genre.posts.page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
  
  end

  def show

    @post = Post.find(params[:id])

  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
end
