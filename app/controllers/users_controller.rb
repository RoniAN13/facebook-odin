class UsersController < ApplicationController
  before_action :authenticate_user! , except: :index
  def index
      if user_signed_in?
      @users = User.all
      
      else
      redirect_to new_user_session_path
      end
  end   
  def show 
      @user= User.find(params[:id])
      @users = @user.friends
      @posts = @user.posts.all

  end  
  def friends
    @user = User.find(params[:id])
    @users = @user.friends
    render 'friends'
  end  
 
end
