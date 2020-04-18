class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: :true, length: { in: 3..50 }
  validates :body, presence: :true, length: { in: 3..1000 }

  def normalized_date
    posted_at
  end
end
