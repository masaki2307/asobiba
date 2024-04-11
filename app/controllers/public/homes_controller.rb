class Public::HomesController < ApplicationController
  def top
    @reviews = Post.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
    @posts = Post.all.order(created_at: :desc).limit(3)
    
  end
end
