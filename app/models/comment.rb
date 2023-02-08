class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :comment, class_name: 'Comment', optional: true
  belongs_to :user
  has_many :sub_comments, -> { order(points: :desc) }, class_name: 'Comment', foreign_key: 'comment_id'
  has_many :comment_votes

  def voted_points
    comment_votes.count
  end

  def hour_past
    ((Time.now - created_at) / 1.hour).round
  end
end
