class PostsController < ApplicationController
  before_action :authenticate_user! 
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :set_post , only: [:upvote, :downvote]
  def create
    @post = current_user.posts.build(post_params)
    if params[:post][:post_file]
    @post.post_file.attach(params[:post][:post_file])
    end
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
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
        @post.update(likes_count: @post.get_likes.size)
        
    elsif current_user.liked? @post
        @post.unliked_by current_user  
        @post.update(likes_count: @post.get_likes.size)
    end    
    
end  
def downvote
  @users = @post.get_dislikes.voters
    if !current_user.disliked? @post
        @post.disliked_by current_user
        @post.update(likes_count: @post.get_likes.size)
        
    elsif current_user.disliked? @post
        @post.undisliked_by current_user
        @post.update(likes_count: @post.get_likes.size)
    end  
   
end        
  private
    def post_params
    params.require(:post).permit(:content, :post_file)
    end
    def set_post
      @post = Post.find(params[:id])
   end
end
