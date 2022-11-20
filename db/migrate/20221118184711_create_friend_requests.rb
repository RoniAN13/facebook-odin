class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :requestor_id , null:false
      t.integer :receiver_id , null:false
      t.string :status, null:false, default:"Pending"

      t.timestamps
    end
    add_index :friend_requests, :requestor_id
    add_index :friend_requests, :receiver_id
    add_index :friend_requests, [:requestor_id,:receiver_id], unique: true
  end
end
