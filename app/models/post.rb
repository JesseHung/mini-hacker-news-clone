class Post < ApplicationRecord
  default_scope { order(points: :desc) }
  belongs_to :user

  has_many :post_upvotes
  paginates_per 10
  has_many :comments

  def voted_points
    post_upvotes.count
  end

  # def points
  #   # let's say G = 1.8 
  #   self.points = (voted_points - 1) / (hour_past + 2) ** 1.8
  #   self.save
  # end

  def hour_past
    ((Time.now - created_at) / 1.hour).round
  end

  def comments_count
    comments.count
  end
end
