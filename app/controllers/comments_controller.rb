class CommentsController < ApplicationController

before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comments = @post.comments.order(id: :DESC)
  end

  def new
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new
    authorize @comment
  end

  def create
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))

    if @comment.save
      flash[:success] = "You have created a comment"
      redirect_to topic_post_comments_path(@topic, @post)
    else
      flash[:danger] = @comment.errors.full_messages
      render new_topic_post_comment_path(@topic, @post)
    end
  end

  def edit
    authorize @comment
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      flash[:success] = "Comment Edited"
      redirect_to topic_post_comments_path(@topic, @post)
    else
      flash[:danger] = @comment.errors.full_messages
      redirect_to edit_topic_post_comment_path(@topic, @post)
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:id])
    authorize @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end

end
