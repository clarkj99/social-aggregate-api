class TimelinesController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    if @user
      comments = @user.comments.order(commented_at: :desc).map do |comment|
        { "id" => comment.id,
         "type" => "comment",
         "message" => comment.message,
         "post" => { post_id: comment.post.id, title: comment.post.title, author: { "name" => comment.post.user.name, avg_rating: comment.post.user.average_rating } },
         "commented_at" => comment.commented_at }
      end

      posts = @user.posts.order(posted_at: :desc).map do |post|
        { "id" => post.id,
         "type" => "post",
         "title" => post.title,
         "comment_count" => post.comments.count,
         "posted_at" => post.posted_at }
      end

      events = []

      if @user.github_username
        events = get_github_events
      end

      ratings = get_breakthrough_ratings(4).map do |rating|
        { "id" => rating.id,
         "type" => "surpass_rating",
         "rating" => rating.rating,
         "rated_at" => rating.rated_at }
      end

      timeline = merge_arrays([posts, events, comments, ratings])
      render json: { meta: { total_events: timeline.count }, data: timeline }
    else
      render json: { meta: { total_events: timeline.count }, data: [] }
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def get_breakthrough_ratings(star_rating)
    ratings = @user.ratings.order(rated_at: :asc)
    current_total = 0
    current_count = 0
    current_average = 0
    ratings.select do |item|
      current_count += 1
      old_average = current_average
      current_total += item.rating
      current_average = current_total / (current_count)
      (old_average < star_rating) && (current_average >= star_rating)
    end
  end

  def get_github_events
    url = "https://api.github.com/users/#{@user.github_username}/events"
    begin
      response = RestClient.get(url)
    rescue RestClient::ExceptionWithResponse => err
      []
    else
      #  create events, push events, pullrequest open, and pullrequest merge
      events = JSON.parse(response).select do |event|
        (["PushEvent", "CreateEvent"].include? (event["type"])) ||
          (event["type"] == "PullRequestEvent" && event["payload"]["action"] == "open") ||
          (event["type"] == "PullRequestEvent" && event["payload"]["action"] == "closed" && event["payload"]["pull_request"]["merged"])
      end
    end
  end

  # perform limited k-way merge with presorted arrays
  def merge_arrays(arrs)
    merged_array = []

    # should limit based on parameter
    50.times do
      populated_arrays = []
      for i in 0..arrs.count - 1
        # only deal with arrays that still contain objects
        if arrs[i].count > 0
          populated_arrays.push(arrs[i])
        end
      end
      merged_array.push(find_winner(populated_arrays))
    end

    merged_array
  end

  def find_winner(arrs)
    n = arrs.count

    # find the array with the first object having the latest date, then shift that object and return it
    max_arr = arrs.max do |a, b|
      sort_date = { "comment" => "commented_at", "post" => "posted_at", "surpass_rating" => "rated_at", "PushEvent" => "created_at", "CreateEvent" => "created_at", "PullRequestEvent" => "created_at" }
      first_date = a[0][sort_date[a[0]["type"]]]
      second_date = b[0][sort_date[b[0]["type"]]]

      first_date <=> second_date
    end
    winner = max_arr[0]
    max_arr.shift
    winner
  end
end
