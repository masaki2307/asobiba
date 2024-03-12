class Public::PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new
    
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end  
  end

  def edit
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
  def post_params
    
    params.require(:post).permit(:introduction, :title, :image, :user_id)
    
  end
  
end
