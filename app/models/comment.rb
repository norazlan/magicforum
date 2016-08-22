class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :votes
  mount_uploader :image, ImageUploader

  def total_votes
  end
end
