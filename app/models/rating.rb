class Rating < ApplicationRecord
  belongs_to :rater
  belongs_to :user
end
