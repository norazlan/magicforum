class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :posts
  validates :title, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true
  belongs_to :user
end
