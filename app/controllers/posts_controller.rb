class PostsController < ApplicationController

  respond_to :js
  before_action :authenticate!, only: [:create, :edit, :update, :new, :destroy]

  def index
    @topic = Topic.includes(:posts).friendly.find(params[:topic_id])
    @posts = @topic.posts.order("created_at DESC")
  end

  def new
    @topic = Topic.find_by(id: params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find_by(id: params[:topic_id])
    @post = current_user.posts.build(post_params.merge(topic_id: params[:topic_id]))

    if @post.save
      flash[:success] = "New Post Created"
      redirect_to topic_posts_path(@topic)
    else
      flash[:danger] = @post.errors.full_messages
      redirect_to new_topic_post_path(@topic)
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
    @topic = @post.topic
    authorize @post
  end

  def update
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.friendly.find(params[:id])

    if @post.update(post_params)
      flash.now[:success] = "Post Edited"
    else
      flash[:danger] = @post.errors.full_messages
    end
  end

  def destroy
    authorize @post
    @post = Post.find_by(id: params[:id])
      @topic = @post.topic

      if @post.destroy
        flash.now[:success] = "Post Deleted"
      else
        flash.now[:danger] = @post.errors.full_messages
      end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :image)
    end

end
