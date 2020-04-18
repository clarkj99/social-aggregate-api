class Post < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :title, presence: :true, length: { in: 3..50 }
  validates :body, presence: :true, length: { in: 3..1000 }
end
