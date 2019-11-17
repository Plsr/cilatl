class BodyTextParser
  def initialize(document)
    unless document.is_a?(Nokogiri::HTML::Document)
      raise ArgumentError.new('document has to be a Nokogiri object')
    end

    @document = document
    @parent_divs = []
    @paragraphs = document.search('p')
    cleanup_document
    rate_divs
  end

  def document_body
    @parent_divs.max_by{ |parent| parent[:points] }.node
  end

  def rate_divs
    @paragraphs.each do |paragraph|
      parent = get_parent_div(paragraph)
      next unless parent

      # Save current paragraphs parent if not already done
      unless (parent_already_known?(parent))
        setup_new_parent(parent)
      end

      el_parent = @parent_divs.detect { |p| p.nokogiri_id == parent.pointer_id}

      paragraph_points = 0
      paragraph_text = paragraph.text
      paragraph_points += paragraph_text.count(',')
      paragraph_points += paragraph_text.count(',')
      paragraph_points += paragraph_text.count('!')
      paragraph_points += paragraph_text.count('?')
      el_parent.points += paragraph_points
    end
  end

  private

  def setup_new_parent(node)
    points = 0
    parent_classes = node.attr('class')
    parent_ids = node.attr('id')

    points -=50 if parent_ids&.match? /(comment|meta|footer|footnote)/
    points +=25 if parent_ids&.match? /(post|hentry|entry|content|text|body|article)/
    points -=50 if parent_classes&.match? /(comment|meta|footer|footnote)/
    points +=25 if parent_classes&.match? /(post|hentry|entry|content|text|body|article)/

    structured_parent = OpenStruct.new(nokogiri_id: node.pointer_id, points: points, node: node)
    @parent_divs << structured_parent
  end

  def parent_already_known?(node)
    @parent_divs.pluck(:nokogiri_id).include?(node.pointer_id)
  end

  def cleanup_document
    @document.search('head').remove
    @document.search('script').remove
    @document.search('form').remove
    @document.search('nav').remove
  end

  def get_parent_div(paragraph)
    return paragraph.parent if (paragraph.parent.name == 'div')
    return nil if (paragraph.parent.name == 'body')
    get_parent_div(paragraph.parent)
  end
end
