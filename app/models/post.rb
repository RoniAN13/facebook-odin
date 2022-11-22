class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }
  has_many :comments,dependent: :destroy
  has_one_attached :post_file
  def display_image
    post_file.variant(resize_to_limit: [500, 500])
    end
end
