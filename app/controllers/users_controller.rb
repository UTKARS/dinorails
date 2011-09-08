class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :not_found, :status => :not_found
  end
  
  def new
    @user = User.new(params[:user])
  end
  
end
