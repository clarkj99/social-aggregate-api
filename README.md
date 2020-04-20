# FIXD Backend Code Challenge

A web service API which designed to provide data to a hypothetical social media application with mobile and web clients.

- Author: Clark Johnson
- Ruby on Rails

## ERD

![FIXD Backend Code Challenge](./public/images/FIXDBackendCodeChallenge.png?raw=true "ERD")

## Getting Started

This project requires Postgres.

- `bundle install`
- `rails db:create` to initalize the Postgres databases "backend_test" and "backend_development"
- `rails db:migrate`,
- `rails db:seed`,
- To run integration specs:
  - `rails db:test:prepare RAILS_ENV=test`
  - `rspec -f d spec/requests/api/posts_spec.rb` -`rspec spec/requests/api/timelines_spec.rb -f d`

## API Documentation

- Swagger documentation is configured for http: server, localhost:3000 by default. Access at /api-docs endpoint when server is running.

### GET /post/:id

Sample return data

```
{
  "data": {
    "id": 0,
    "title": "string",
    "body": "string",
    "posted_at": "2020-04-20T06:15:41.659Z",
    "user": {
      "name": "string",
      "average_rating": 0
    },
    "comments": [
      {
        "id": 0,
        "message": "string",
        "commented_at": "2020-04-20T06:15:41.659Z",
        "user": {
          "name": "string",
          "average_rating": 0
        }
      }
    ]
  }
}
```

### POST /posts

Since this API is currently implemented without authentication, the user `id` must be supplied, Once authentication is in place, the `id` will be taken from the token.

Request header: "Content-Type":"application/json"

Request body:

```
{
  "title": "string",
  "body": "string",
  "posted_at": "2017-09-22T12:13:05.000Z",
  "user_id": 1
}
```

### GET /timelines/:user_id

The `data` array from the timelines endpoint can contain objects of six OBJECT_TYPEs: `comment`, `post`, `surpass_rating`, `PushEvent`, `CreateEvent`, `PullRequestEvent`

```
{
  "meta": {
    "timeline_count": 0
  },
    "data": [
      {
        "id": 0,
        "type": OBJECT_TYPE,
          ... other attributes for this OBJECT_TYPE...
      }
    ]
}
```

#### comment example

```
{
  "id": 24199,
  "type": "comment",
  "message": "She's dead... Wrapped in plastic.",
  "post": {
    "post_id": 736,
    "title": "When The Going Gets Tough, The Tough Reinvent",
    "author": {
      "name": "Jessica Wild",
      "avg_rating": 4
    }
  },
"commented_at": "2017-09-07T00:07:46.000Z"
},
```

#### post example

```
{
  "id": 106,
  "type": "post",
  "title": "I don't wanna talk. I wanna shoot.",
  "comment_count": 2,
  "posted_at": "2017-11-20T17:54:29.000Z"
}
```

#### surpass_rating example

```
{
  "id": 3215,
  "type": "surpass_rating",
  "rating": 4,
  "rated_at": "2017-09-29T18:23:51.000Z"
},
```

## Todo

- [x] Create rails boilerplate
  - remove Rails 6 unused routes: Action Mailer, Action Mailbox, Active Storage
  - `rails new backend --api --database=postgresql --skip-action-mailer --skip-action-mailbox --skip-active-storage`
- [x] Add rspec and rswag
  - `rails g rspec:install`
  - `rails g rswag:install`
- [x] Add scaffold for Users, Posts, Comments, Ratings
  - `rails g scaffold Users email name github_username registered_at:datetime`
  - `rails g scaffold Posts title body user:references posted_at:datetime`
  - `rails g scaffold Commentss message user:references post:references commented_at:datetime`
  - `rails g scaffold Ratings rating:integer rater:references user:references rated_at:datetime`
- [x] Add model relationships
- [x] Add validation rules
- [x] Import sample data
  - Data is available to import via `rails db:seed` from four CSVs: users.csv, posts.csv, comments.csv, and ratings.csv
  - Before testing, seed data can be loaded to test via `rails db:test:prepare RAILS_ENV=test`
- [x] Add timeline endpoint
  - `rails g controller Timelines show`
- [x] Create integration tests for Swagger

  - Integration tests configured for these endpoints:

    - get /post/{id}
    - post /posts
    - get /timelines/{user_id}
    - get /users/{id}

  - Swagger docs genereated via `rails rswag`

- [ ] Implement page and limit for timelines
- [ ] Implement JWT Authentication
- [ ] Add Integration testing and documentation across all planned endpoints, especially the edits and updates
- [ ] Clean up routes

## Endpoints

- All routes currently implemented as resources. Routes will be restricted after authentication is implemented and testing nears completion.
- get /users/:id
- get /timelines/:userid
- put /posts
- put /comments
- delete /comments/:id
- put /ratings
