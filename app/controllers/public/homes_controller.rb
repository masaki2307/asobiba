class Public::HomesController < ApplicationController
  def top
    @reviews = Post.all.order(review: :desc).limit(3)
    @posts = Post.all.order(created_at: :desc).limit(3)
    
  end
end
