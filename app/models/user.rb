class User < ApplicationRecord
  include Clearance::User

  has_many :bookmarks
  has_many :fields, through: :bookmarks
end
