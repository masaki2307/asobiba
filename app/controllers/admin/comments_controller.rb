class Admin::CommentsController < ApplicationController
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @post = Post.find(params[:post_id])
    redirect_to admin_post_path(@post)
  end
  
end