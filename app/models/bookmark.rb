class Bookmark < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates :fields, presence: true
end
