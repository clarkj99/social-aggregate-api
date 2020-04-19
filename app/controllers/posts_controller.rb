class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.order(posted_at: :desc)

    render json: { meta: { total_posts: @posts.count }, data: JSON.parse(@posts.to_json(only: [:id, :title, :body, :posted_at])) }
  end

  # GET /posts/1
  def show
    render json: { data: JSON.parse(@post.to_json(only: [:id, :title, :body, :posted_at], include: { user: { only: [:name], methods: :average_rating }, comments: { only: [:id, :message, :commented_at], include: { user: { only: [:name], methods: :average_rating } } } })) }
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: { data: @post }, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: { data: @post }
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :body, :user_id, :posted_at)
  end
end
