class TimelinesController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    evaluations = @user.evaluations.order(rated_at: :desc).map do |evaluation|
      { type: "evaluation",
        data: evaluation }
    end

    posts = @user.posts.order(posted_at: :desc).map do |post|
      { type: "post",
        data: post }
    end

    events = []

    if @user.github_username
      events = get_github_events.map do |event|
        { type: "github",
          data: event }
      end
    end

    ratings = get_breakthrough_ratings.map do |rating|
      { type: "rating_breakthrough",
        data: rating }
    end

    # Combine arrays and sort by date descending
    timeline = (evaluations + posts + events + ratings).sort do |a, b|
      # github event created_at date is stored in hash,
      #  rating and post are stored in a method
      if a[:data].is_a? Hash
        first_date = a[:data]["created_at"]
      else
        first_date = a[:"data"].normalized_date
      end
      if b[:data].is_a? Hash
        second_date = b[:data]["created_at"]
      else
        second_date = b[:data].normalized_date
      end
      second_date <=> first_date
    end
    render json: timeline[0..31]
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def get_breakthrough_ratings
    ratings = @user.ratings.order(rated_at: :asc)
    current_total = 0
    current_count = 0
    current_average = 0
    ratings.select do |item|
      current_count += 1
      old_average = current_average
      current_total += item.rating
      current_average = current_total / (current_count)
      (old_average < 4) && (current_average >= 4)
    end
  end

  def get_github_events
    url = "https://api.github.com/users/#{@user.github_username}/events"
    begin
      response = RestClient.get(url)
    rescue RestClient::ExceptionWithResponse => err
      []
    else
      events = JSON.parse(response).select do |event|
        ["PushEvent", "CreateEvent", "PullRequestEvent"].include? (event["type"])
      end
    end
  end
end
