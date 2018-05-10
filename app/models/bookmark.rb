class Bookmark < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :link, presence: true
  validates :fields, presence: true

  scope :unarchived, -> { where(archived: false) }

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
end
