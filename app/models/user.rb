class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :ratings
  has_many :evaluations, foreign_key: "rater_id", class_name: "Rating"
end
