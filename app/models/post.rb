class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 64 }
  validates :body, presence: true, length: { maximum: 1024 }
  belongs_to :user
  # Retrieve the posts from the database in descending order of creation time.
  default_scope -> { order(created_at: :desc) }
end
