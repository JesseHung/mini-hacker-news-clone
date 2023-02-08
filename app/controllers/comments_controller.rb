class CommentsController < ApplicationController
  before_action :set_post, only: %w[create]
  before_action :set_comment, only: %w[upvote unvote show]
  before_action :authenticate_user!, only: %w[create upvote unvote]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = "New post is created successfully."
    end

    redirect_to post_url(comment_params[:post_id])
  end

  def show
    @sub_comments = @comment.sub_comments
    @post = @comment.post
    @new_comment = Comment.new
  end

  def upvote
    if vote_exists?
      redirect_to redirect_str
      return
    end
    
    new_vote = current_user.comment_votes.new
    new_vote.comment = @comment

    if new_vote.save
      flash[:success] = "Comment is upvoted successfully."
    end
    
    redirect_to redirect_str
  end

  def unvote
    if !vote_exists?
      redirect_to redirect_str
      return
    end

    vote = current_user.comment_votes.where(comment_id: @comment.id).first

    if vote.present? && vote.delete
      flash[:success] = "Comment is unvoted successfully."
    end
    
    redirect_to redirect_str
  end

  private

  def set_post
    @post ||= Post.find_by(id: comment_params[:post_id])
  end

  def set_comment
    @comment ||= Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :level, :comment_id)
  end

  def vote_exists?
    @comment.comment_votes.exists?(user_id: current_user.id)
  end

  def redirect_str
    "/posts/#{@comment.post.id}"
  end
end
