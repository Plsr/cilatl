require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "creation" do
    let(:tag) { FactoryBot.build(:tag) }

    it "is valid with valid attributes" do
      expect(tag.valid?).to be(true)
    end

    it "is not valid with a duplicate name" do
      tag = FactoryBot.create(:tag)
      dupe_name_tag = FactoryBot.build(:tag, name: tag.name)
      expect(dupe_name_tag.valid?).to be(false)
    end
  end
end
