class User < ApplicationRecord
  include Clearance::User

  has_many :bookmarks

  def tag_names
    bookmarks.map(&:tag_names).uniq!
  end
end
