require 'rails_helper'

RSpec.describe Field, type: :model do
  describe "creation" do
    let(:field) { FactoryBot.build(:field) }

    it "is valid with valid attributes" do
      expect(field.valid?).to be(true)
    end

    it "is not valid with a duplicate name" do
      field = FactoryBot.create(:field)
      dupe_name_field = FactoryBot.build(:field, name: field.name)
      expect(dupe_name_field.valid?).to be(false)
    end
  end
end
