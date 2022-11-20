class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  has_many :comments,dependent: :destroy
  

end
