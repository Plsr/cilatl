require 'rails_helper'

RSpec.describe BodyTextParser, type: :model do
  describe 'initialization' do
    it 'is valid when initialized with an Instance of Nokogiri' do
      html = Nokogiri::HTML('<!DOCTYPE html><html><body><div>foo</div></body></html>')
      expect { BodyTextParser.new(html) }.not_to raise_error
    end

    it 'it throws when initialized without an HTML Instance of Nokogiri' do
      string = 'Some string'
      expect { BodyTextParser.new(string) }.to raise_error(ArgumentError)
    end
  end
end

