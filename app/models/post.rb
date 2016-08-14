class Post < ApplicationRecord
  has_many :comments
  belongs_to :topic
  belongs_to :user
  mount_uploader :image, ImageUploader
end
