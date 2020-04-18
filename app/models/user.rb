class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :posts
  has_many :comments
  has_many :ratings
  has_many :evaluations, foreign_key: "rater_id", class_name: "Rating"

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }

  validates :name, presence: true, length: { maximum: 50 }
end
