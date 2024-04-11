class Public::PostsController < ApplicationController
  def index
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    
    if params[:search].present?
      @posts = Post.joins(:user).where("title LIKE (?) OR users.name LIKE (?)", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]) 
    elsif params[:genre_name].present?
      @genre = Genre.find_by(name: params[:genre_name])
      
      @posts = @genre.posts.page(params[:page])
    elsif @start_date && @end_date
      @posts = Post.where(created_at: @start_date..@end_date).page(params[:page]) 
    elsif params[:sort_created].present?  
      @posts = Post.order(created_at: :desc).page(params[:page]) 
    elsif params[:sort_review].present?  
      # @posts = Post.where(id: Favorite.group(:post_id).order('count(post_id) desc').pluck(:post_id)).page(params[:page]) 
      posts_arr = Post.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
      @posts = Kaminari.paginate_array(posts_arr).page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
  
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page])
  end

  def new
    @post = Post.new
    @genres = Genre.all
    
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.genre_id = params[:post][:genre_id]
    if @post.save
      flash[:notice] = "投稿完了しました！"
      redirect_to post_path(@post)
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    if Post.exists?(id: params[:id])
       @post = Post.find(params[:id])
    else 
      #@post = Post.find(params[:id])
      #@user = @post.user
      @user = User.find(params[:user_id])
      redirect_to post_list_path(@user)
    end
  end
# User.exists?(name: '田中')
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
    @user = User.find(params[:user_id])
    redirect_to post_list_path(@user)
  end

  private

  def post_params

    params.require(:post).permit(:introduction, :title, :image, :user_id, :genre_id, :review)

  end
  

end
