class User < ApplicationRecord
  has_secure_password
  has_many :topics
  has_many :posts
  has_many :comments
  mount_uploader :image, ImageUploader

  enum role: [:user, :moderator, :admin]
end
