require "swagger_helper"

RSpec.describe "api/posts", type: :request do
  schema_properties = { title: { type: :string },
                        body: { type: :string },
                        posted_at: { type: :string },
                        user_id: { type: :number } }

  path "/posts/{id}" do
    get "Retrieve a post" do
      tags "Posts"
      produces "application/json"
      parameter name: :id, in: :path, type: :number
      #   parameter name: :page, in: :query, type: :integer
      response "200", "post found" do
        schema type: :object,
               properties: {
                 data: { type: :object, properties: { id: { type: :number }, title: { type: :string }, body: { type: :string }, posted_at: { type: :string, format: "date-time" }, user: { type: :object }, comments: { type: :array, items: { type: :object } } } },
               },
               required: ["data"]

        let(:id) { Post.first.id }

        run_test!
      end
    end
  end

  path "/posts" do
    post "Create a Post" do
      tags "Posts"
      consumes "application/json"
      parameter name: :peace, in: :body, schema: {
                  type: :object,
                  properties: schema_properties,
                  required: ["title", "body", "user_id"],
                  example: {
                    title: "This is a title",
                    body: "This is a sentence",
                    posted_at: "2017-09-22T12:13:05.000Z",
                    user_id: 1,
                  },
                }
      response "201", "post created" do
        let(:peace) { { title: "This is a title", body: "This is a sentence", user_id: User.first.id } }
        run_test!
      end
      response "422", "invalid request" do
        let(:peace) { { title: "Valid Title" } }
        run_test!
      end
    end
  end
end
