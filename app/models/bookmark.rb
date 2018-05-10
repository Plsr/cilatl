class Bookmark < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true
  validates :fields, presence: true
end
