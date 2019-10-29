class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :media_type
  has_and_belongs_to_many :fields
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :link, presence: true

  attr_accessor :tags_string

  scope :unarchived, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def archive
    self.archived = true
    self.archived_on = DateTime.current
    self.save
  end

  def unarchive
    self.archived = false
    self.archived_on = nil
    self.save
  end

  def tags_string
    tags.map { |f| f.name }.join(', ')
  end

  # TODO: Is this needed?
  def tags_string=(value)
    value.split(/,\s+/)
  end
end
