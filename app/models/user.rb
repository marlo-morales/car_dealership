class User < ApplicationRecord
  has_secure_password

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :first_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
