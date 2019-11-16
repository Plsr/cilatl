class BodyTextParser
  def initialize(document)
    unless document.is_a?(Nokogiri::HTML::Document)
      raise ArgumentError.new('document has to be a Nokogiri object')
    end

    @document = document
  end
end
