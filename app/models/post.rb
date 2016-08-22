class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :comments
  belongs_to :topic
  belongs_to :user
  mount_uploader :image, ImageUploader
end
