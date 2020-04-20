require "swagger_helper"

RSpec.describe "api/users", type: :request do
  path "/users/{id}" do
    get "Retrieve a single user" do
      tags "User"
      produces "application/json"
      parameter name: :id, in: :path, type: :number
      response "200", "user found" do
        schema type: :object,
               properties: { id: { type: :number },
                             email: { type: :string },
                             name: { type: :string },
                             github_username: { type: :string },
                             registered_at: { type: :string, format: "date-time" } },
               required: ["id", "email", "name", "average_rating"]
        let(:id) { User.first.id }
        run_test!
      end

      response "404", "user not found" do
        let(:id) { "invalid" }
        run_test!
      end
    end
  end
end
