require 'rails_helper'

RSpec.describe "Timelines", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/timelines/show"
      expect(response).to have_http_status(:success)
    end
  end

end
