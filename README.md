# FIXD Backend Code Challenge

- Author: Clark Johnson
- Ruby on Rails

## ERD

![FIXD Backend Code Challenge](./public/images/erd.png?raw=true "ERD")

## Sample Data

Data is available to import via `rails db:seed` from four CSVs: users.csv, posts.csv, comments.csv, and ratings.csv

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
- [ ] Add timeline endpoint
- [ ] Create integration tests for Swagger
- [ ] Authenticate

## Endpoints

- get /users/:id
- get /timelines/:userid
- put /posts
- put /comments
- delete /comments/:id
- put /ratings
