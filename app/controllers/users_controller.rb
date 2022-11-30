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
      fullname = params[:fullname].split("-")
      firstname= (fullname.first).split('_').join(' ')
      lastname= (fullname.last).split('_').join(' ')
      @user= User.find_by(firstname:firstname,lastname:lastname)
      @users = @user.friends
      @posts = @user.posts.all

  end  
  def friends
    fullname = params[:fullname].split("-")
    firstname= (fullname.first).split('_').join(' ')
    lastname= (fullname.last).split('_').join(' ')
    @user= User.find_by(firstname:firstname,lastname:lastname)
    @users = @user.friends
    render 'friends'
  end  
 
end
