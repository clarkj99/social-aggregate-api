require "swagger_helper"

RSpec.describe "api/users", type: :request do
  path "/users/{id}" do
    get "Retrieve a single user" do
      tags "User"
      produces "application/json"
      parameter name: :id, in: :path, type: :number
      response "200", "user found" do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :string },
                     type: { type: :string },
                     attributes: {
                       type: :object,
                       properties: {
                         id: { type: :number, required: true }, email: { type: :string, required: true },
                         name: { type: :string, required: true },
                         github_username: { type: :string },
                         registered_at: { type: :string, required: true, format: "date-time" },
                       },
                     },
                   },
                 },
               }
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
