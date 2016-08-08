class CommentsController < ApplicationController

  def index
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @comments = @post.comments.order("created_at DESC")
  end

  def new
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(comment_params.merge(post_id: params[:post_id]))

    if @comment.save
      redirect_to topic_post_comments_path(@post)
    else
      render new_topic_post_comment_path(@post)
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:post_id])

    if @comment.update(comment_params)
      redirect_to topic_post_comments_path(@comment)
    else
      redirect_to edit_topic_post_comment_path(@comment)
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
