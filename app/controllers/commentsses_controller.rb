class CommentssesController < ApplicationController
  before_action :set_commentss, only: [:show, :update, :destroy]

  # GET /commentsses
  def index
    @commentsses = Commentss.all

    render json: @commentsses
  end

  # GET /commentsses/1
  def show
    render json: @commentss
  end

  # POST /commentsses
  def create
    @commentss = Commentss.new(commentss_params)

    if @commentss.save
      render json: @commentss, status: :created, location: @commentss
    else
      render json: @commentss.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /commentsses/1
  def update
    if @commentss.update(commentss_params)
      render json: @commentss
    else
      render json: @commentss.errors, status: :unprocessable_entity
    end
  end

  # DELETE /commentsses/1
  def destroy
    @commentss.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commentss
      @commentss = Commentss.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def commentss_params
      params.require(:commentss).permit(:message, :user_id, :post_id, :commented_at)
    end
end
