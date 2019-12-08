class Highlight < ApplicationRecord
  belongs_to :bookmark

  validates_presence_of :index_in_article
  validates_uniqueness_of :index_in_article, scope: :bookmark
  validates_presence_of :text
end
