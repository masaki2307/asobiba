class Public::PostsController < ApplicationController
  def index
    if params[:search].present?
      @posts = Post.joins(:user).where("title LIKE (?) OR users.name LIKE (?)", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]) 
    elsif params[:genre_name].present?
      @genre = Genre.find_by(name: params[:genre_name])
      @posts = @genre.posts.page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
      #  
    genre_seach
  end

  def show
    @post = Post.find(params[:id])
    genre_seach
  end

  def new
    @post = Post.new
    @genres = Genre.all
    genre_seach
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.genre_id = params[:post][:genre_id]
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    genre_seach
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.genre_id = params[:post][:genre_id]
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to post_list_path
  end

  private

  def post_params

    params.require(:post).permit(:introduction, :title, :image, :user_id, :genre_id)

  end

end
