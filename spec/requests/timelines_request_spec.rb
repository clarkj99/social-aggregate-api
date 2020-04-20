require "rails_helper"

RSpec.describe "Timelines", type: :request do
  describe "GET /show" do
    it "returns http success" do
      # user = User.create({ email: "Dan@email.com", name: "Dan Johnson", github_username: "clarkj99", registered_at: Time.new })
      user = User.first
      get timelines_url(user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
