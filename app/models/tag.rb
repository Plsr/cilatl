class Tag < ApplicationRecord
  has_and_belongs_to_many :bookmarks

  validates :name, presence: true, uniqueness: true

  def add_bookmark(bookmark)
    self.bookmarks << bookmark
    self.save
  end
end
