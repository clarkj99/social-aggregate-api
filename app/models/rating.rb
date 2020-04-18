class Rating < ApplicationRecord
  belongs_to :rater, class_name: "User"
  belongs_to :user

  validates :rating, presence: true
end
