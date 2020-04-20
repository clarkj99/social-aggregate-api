class Rating < ApplicationRecord
  belongs_to :rater, class_name: "User"
  belongs_to :user

  validates :rating, presence: true, inclusion: 1..5
  validates :rated_at, presence: :true
end
