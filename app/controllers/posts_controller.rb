class PostsController < ApplicationController
  before_action :set_post, only: %w[show upvote unvote]
  before_action :authenticate_user!, only: %w[new create upvote unvote]

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.where('comment_id IS NULL')
    @new_comment = Comment.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "New post is created successfully."
      redirect_to '/'
    else
      render :new
    end
  end

  def upvote
    if vote_exists?
      redirect_to redirect_str
      return
    end
    
    new_vote = current_user.post_upvotes.new
    new_vote.post = @post 

    if new_vote.save
      flash[:success] = "Post is upvoted successfully."
    end
    
    redirect_to redirect_str
  end

  def unvote
    if !vote_exists?
      redirect_to redirect_str
      return
    end

    vote = current_user.post_upvotes.where(post_id: @post.id).first

    if vote.present? && vote.delete
      flash[:success] = "Post is unvoted successfully."
    end
    
    redirect_to redirect_str
  end

  private

  def set_post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def vote_exists?
    @post.post_upvotes.exists?(user_id: current_user.id)
  end

  def redirect_str
    redirect_str = "/welcome/index"
    if params[:page].present?
      redirect_str += "?page=#{params[:page]}"
    end

    redirect_str
  end
end
