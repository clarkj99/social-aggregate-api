require "swagger_helper"

RSpec.describe "api/timelines", type: :request do
  schema_properties = {
    meta: { type: :object },
    data: { type: :object },
  }

  path "/timelines/{user_id}" do
    parameter name: :user_id, in: :path, type: :string
    get "Retrieve a user's timeline" do
      tags "Timelines"
      produces "application/json"
      #   parameter name: :page, in: :query, type: :integer
      response "200", "timeline found" do
        schema type: :object,
               properties: {
                 meta: { type: :object,
                         properties: { timeline_count: { type: :number } } },
                 data: { type: :array, items: { type: :object } },
               },
               required: ["meta", "data"]
        let(:user_id) { User.first.id }
        # let(:page) { 1 }
        run_test!
      end
    end
  end
end
