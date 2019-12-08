require 'rails_helper'

RSpec.describe Highlight, type: :model do
  describe "validation" do
    let(:bookmark) { FactoryBot.create(:bookmark) }

    it "does not allow the same text with the same index_in_article on a bookmark" do
      FactoryBot.create(:highlight, index_in_article: 0, bookmark: bookmark)
      second_highlight = FactoryBot.build(:highlight, index_in_article: 0, bookmark: bookmark)

      expect(second_highlight.valid?).to eq(false)
    end
  end
end
