class FriendRequestsController < ApplicationController
  def create
    id1 = params[:ids][:id1]
    id2 = params[:ids][:id2]
    @friend_request = FriendRequest.new(requestor_id: id1, receiver_id: id2)
    @friend_request.save
    redirect_to users_path
  end

  def destroy
    friend_request = FriendRequest.find(params[:friend_request_id])
    friend_request.destroy
    redirect_to user_path(current_user.id)
  end

  def update
    friend_request = FriendRequest.find(params[:friend_request_id])
    
    FriendRequest.update(status: "Accepted")
    redirect_to user_path(friend_request.receiver_id)
  end
  
    
end