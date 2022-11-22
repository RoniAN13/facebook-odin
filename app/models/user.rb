class User < ApplicationRecord
 
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
has_many :friend_requests
has_many :pending_requests, -> { where status: "Pending" }, class_name: 'FriendRequest', foreign_key: "receiver_id"
has_many :posts, dependent: :destroy
after_create_commit { broadcast_append_to "users" }
has_many :comments, dependent: :destroy

def friends
  friends_i_sent_request = FriendRequest.where(requestor_id: id, status:"Accepted").pluck(:receiver_id)
  friends_i_got_request = FriendRequest.where(receiver_id: id, status:"Accepted").pluck(:requestor_id)
  ids = friends_i_sent_request + friends_i_got_request
  User.where(id: ids)
end

def friend_with?(user)
  FriendRequest.confirmed_record?(id, user.id)
end

def send_request(user)
  friend_requests.create(receiver_id: user.id)
end 
def fullname(user)  
   fullname =  "#{user.firstname} #{user.lastname}"    
   return fullname 
end 
def feed
  friends_i_sent_request = FriendRequest.where(requestor_id: id, status:"Accepted").pluck(:receiver_id)
  friends_i_got_request = FriendRequest.where(receiver_id: id, status:"Accepted").pluck(:requestor_id)
  ids = friends_i_sent_request + friends_i_got_request
  ids.push(id)
  return Post.where(user_id: ids)
  end
end
