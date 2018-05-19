class Field < ApplicationRecord
  has_and_belongs_to_many :bookmarks

  validates :name, presence: true, uniqueness: true
end
