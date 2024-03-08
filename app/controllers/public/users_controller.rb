class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    
    @user = User.find(params[:id])
    
  end

  def edit
  end

  def index
  end

  def confirm
  end
end
