class PostsController < ApplicationController
  before_action :authenticate_user! 
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :set_post , only: [:upvote, :downvote]
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_url
      else
        @feed_items = current_user.feed.all
      render 'static_pages/home'
      end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end
  def upvote
    @users = @post.get_likes.voters
    if !current_user.liked? @post
        @post.liked_by current_user
    
        
    elsif current_user.liked? @post
        @post.unliked_by current_user  
    
    end    
    
end  
def downvote
  @users = @post.get_dislikes.voters
    if !current_user.disliked? @post
        @post.disliked_by current_user
        
    elsif current_user.disliked? @post
        @post.undisliked_by current_user
     
    end  
   
end        
  private
    def post_params
    params.require(:post).permit(:content)
    end
    def set_post
      @post = Post.find(params[:id])
   end
end
