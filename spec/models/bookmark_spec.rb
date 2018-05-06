require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'validation' do
    let!(:bookmark) { FactoryBot.build(:bookmark) }

    it 'is valid with valid attributes' do
      expect(bookmark.valid?).to be(true)
    end

    it 'is not valid without a title' do
      bookmark.title = nil
      expect(bookmark.valid?).to be(false)
    end

    it 'is not valid without a url' do
      bookmark.url = nil
      expect(bookmark.valid?).to be(false)
    end

    it 'is not valid without fields' do
      bookmark.fields = []
      expect(bookmark.valid?).to be(false)
    end
  end
end

