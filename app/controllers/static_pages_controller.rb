class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home
     if user_signed_in?
      @post = current_user.posts.build
      if params[:commit]
      if params[:commit] = "Search"
      
      @feed_items = Post.search(current_user,search_params)  
        render 'home'
      end
    else
      @feed_items = current_user.feed.all 

    end
  end
  end
 private
 def search_params
  params.require(:search).permit(:date_from,:date_to,:likes_from,:likes_to,:user_ids =>[]) 
 end 
end
