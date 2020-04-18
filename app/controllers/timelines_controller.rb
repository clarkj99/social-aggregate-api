class TimelinesController < ApplicationController
  def show
    user = User.find_by(id: params[:user_id])
    evaluations = user.evaluations
    posts = user.posts

    timeline = (evaluations + posts).sort { |a, b| b.normalized_date <=> a.normalized_date }

    render json: timeline
  end
end
