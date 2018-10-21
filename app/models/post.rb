class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 64 }
  validates :body, presence: true, length: { maximum: 1024 }
  belongs_to :user
end
