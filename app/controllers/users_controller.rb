class UsersController < ApplicationController

  before_filter :load_user, :only => [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end
  
  def show
    render
  end
  
  def new
    @user = User.new(params[:user])
  end
  
  def edit
    render
  end

  def create
    @user = User.new(params[:user])
    @user.save!
    flash[:notice] = 'User created'
    redirect_to :action => :show, :id => @user
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to create user'
    render :new
  end
  
  def update
    @user.update_attributes!(params[:user])
    flash[:notice] = 'User updated'
    redirect_to :action => :show, :id => @user
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = 'Failed to update User'
    render :edit
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User deleted'
    redirect_to :action => :index
  end

protected
  
  def load_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render :not_found, :status => :not_found
  end
  
end
