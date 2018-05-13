class MediaType < ApplicationRecord
  has_many :bookmarks
  validates :name, presence: true
end
