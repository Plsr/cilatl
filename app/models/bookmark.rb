class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :media_type
  has_and_belongs_to_many :fields
  has_and_belongs_to_many :tags

  before_validation :convert_fields_list_to_array

  validates :title, presence: true
  validates :link, presence: true
  validates :fields, presence: true

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

  def fields_list
    fields.map { |f| f.name }.join(', ')
  end

  def fields_list=(value)
    field_names = value.split(/,\s+/)
    if field_names.length > 10
      errors.add(:fields, :too_many, message: "no more then 10 fields are allowed")
    end
    self.fields = field_names.map { |name| Field.find_or_create_by(name: name) }
  end

  private

  def convert_fields_list_to_array
    fields_list = fields_list.split(/,\s+/) if fields_list
  end
end
