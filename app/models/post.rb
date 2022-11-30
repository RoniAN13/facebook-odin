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
    def self.search(user,search_params) 
      if search_params.empty?
          nil
      else 
       
      results = user.feed.all
      results=results.where(['created_at >= ?',search_params[:date_from] ])if search_params[:date_from].present?
      results=results.where([ 'created_at <= ?',search_params[:date_to]])  if search_params[:date_to].present?
      results=results.where([ 'likes_count >= ?',search_params[:likes_from]])  if search_params[:likes_from].present?
      results=results.where([ 'likes_count <= ?',search_params[:likes_to]])  if search_params[:likes_to].present?
      if !search_params[:user_ids][1].nil?  
      a = search_params[:user_ids].map do |b| b.to_i end
      results=results.where(user_id:a)  
      end      
      return results
      end
  end 
end
