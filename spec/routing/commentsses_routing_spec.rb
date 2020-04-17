require "rails_helper"

RSpec.describe CommentssesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/commentsses").to route_to("commentsses#index")
    end

    it "routes to #show" do
      expect(get: "/commentsses/1").to route_to("commentsses#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/commentsses").to route_to("commentsses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/commentsses/1").to route_to("commentsses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/commentsses/1").to route_to("commentsses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/commentsses/1").to route_to("commentsses#destroy", id: "1")
    end
  end
end
