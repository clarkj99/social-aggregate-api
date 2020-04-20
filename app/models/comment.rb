class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :message, presence: :true
  validates :commented_at, presence: :true
end
