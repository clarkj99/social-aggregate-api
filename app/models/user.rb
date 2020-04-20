class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :evaluations, foreign_key: "rater_id", class_name: "Rating", dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }

  validates :name, presence: true, length: { maximum: 50 }
  validates :registered_at, presence: :true

  def average_rating
    if self.ratings.count > 0
      self.ratings.map { |r| r.rating }.sum / self.ratings.count
    else
      1
    end
  end
end
