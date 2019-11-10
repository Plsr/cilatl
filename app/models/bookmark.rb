class Bookmark < ApplicationRecord
  Gutentag::ActiveRecord.call self

  belongs_to :user
  belongs_to :media_type

  validates :title, presence: true
  validates :link, presence: true

  # TODO: Remove
  attr_accessor :tags_string

  scope :unarchived, -> { where(archived: false).order(created_at: :desc) }
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
    tag_names.join(', ')
  end

  # TODO: Remove
  def tags_string=(value)
    value.split(/,\s+/)
  end
end
