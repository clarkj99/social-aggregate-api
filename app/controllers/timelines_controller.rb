class TimelinesController < ApplicationController
  def show
    user = User.find_by(id: params[:user_id])
    evaluations = user.evaluations
    posts = user.posts

    events = []
    if user.github_username
      events = github_events(user.github_username)
    end

    # Combine arrays and sort by date descending
    timeline = (evaluations + posts + events).sort do |a, b|
      # github event created_at date is stored in hash,
      #  rating and post are stored in a method
      if a.is_a? Hash
        first_date = a["created_at"]
      else
        first_date = a.normalized_date
      end
      if b.is_a? Hash
        second_date = b["created_at"]
      else
        second_date = b.normalized_date
      end
      second_date <=> first_date
    end

    render json: timeline
  end

  private

  def github_events(username)
    url = "https://api.github.com/users/#{username}/events"
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
