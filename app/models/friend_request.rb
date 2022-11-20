class FriendRequest < ApplicationRecord
    belongs_to :requestor, class_name: "User"
    belongs_to :receiver, class_name: "User"
    validates :requestor_id, presence: true
    validates :receiver_id, presence: true

  def self.reacted?(id1, id2)
    case1 = !FriendRequest.where(requestor_id: id1, receiver_id: id2).empty?
    case2 = !FriendRequest.where(requestor_id: id2, receiver_id: id1).empty?
    case1 || case2
  end

  def self.confirmed_record?(id1, id2)
    case1 = !FriendRequest.where(requestor_id: id1, receiver_id: id2, status:"Accepted").empty?
    case2 = !FriendRequest.where(requestor_id: id2, receiver_id: id1, status:"Accepted").empty?
    case1 || case2
  end

  def self.find_request(id1, id2)
    if FriendRequest.where(requestor_id: id1, receiver_id: id2, status:"Accepted").empty?
      FriendRequest.where(requestor_id: id2, receiver_id: id1, status:"Accepted")[0].id
    else
      FriendRequest.where(requestor_id: id1, receiver_id: id2, status:"Accepted")[0].id
    end
  end
end
