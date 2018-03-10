class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: "User"

  validates :body, :post_id, :author_id, presence: true
end
