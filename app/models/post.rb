class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy

  validates :title, :body, :author_id, presence: true

  scope :ordered, -> { order(updated_at: :desc) }
end
