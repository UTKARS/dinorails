class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'User not found'
    redirect_to :action => :index
  end
  
end
