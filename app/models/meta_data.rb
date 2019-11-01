class MetaData
  CONFIG = { connection_timeout: 5, read_timeout: 5, retries: 1 }.freeze
  attr_reader :url, :service

  def initialize(url, service = MetaInspector)
    @url = url || ''
    @service = service
  end

  def page
    result = @service.new(url, CONFIG)
    { title: result.title, description: result.best_description, link: result.url, fields: result.meta['keywords'] || '', page: page_content(result.parsed) }
  rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::ParserError
    Rails.logger.error("MetaInspector failed to load #{url}")
    {}
  end

  private

  def page_content(page)
    # Remove some we are reasonably sure about not containing the main
    # content of the page
    page.search('head').remove
    page.search('script').remove
    page.search('form').remove
    page.search('nav').remove

    paragraphs = page.search('p')

    # Move thorugh all the paragraphs and identify their parent <div>s
    # Save all the parents into some(?) structure that is searchable and allows
    # for adding points to the parent

    parents = []

    paragraphs.each do |paragraph|
      parent = get_parent_div(paragraph)

      # Save current paragraphs parent if not already done
      unless (parents.pluck(:nokogiri_id).include?(parent.pointer_id))
        # Set initial point base on classnames and ids
        points = 0
        parent_classes = parent.attr('class')
        parent_ids = parent.attr('id')

        points -=50 if parent_ids&.match? /(comment|meta|footer|footnote)/
        points +=25 if parent_ids&.match? /(post|hentry|entry|content|text|body|article)/
        points -=50 if parent_classes&.match? /(comment|meta|footer|footnote)/
        points +=25 if parent_classes&.match? /(post|hentry|entry|content|text|body|article)/

        # Save new parent
        structured_parent = OpenStruct.new(nokogiri_id: parent.pointer_id, points: points, node: parent)
        parents << structured_parent
      end

      el_parent = structured_parent || parents.detect { |p| p.nokogiri_id == parent.pointer_id}

      paragraph_points = 0
      paragraph_text = paragraph.text
      paragraph_points += paragraph_text.count(',')
      paragraph_points += paragraph_text.count(',')
      paragraph_points += paragraph_text.count('!')
      paragraph_points += paragraph_text.count('?')
      el_parent.points += paragraph_points
    end

    # byebug
    # pp parents.pluck(:points)
    # pp paragraphs.length
    parents.max_by{|parent| parent[:points] }.node
  end

  def get_parent_div(paragraph)
    return paragraph.parent if (paragraph.parent.name == 'div')
    return nil if (paragraph.parent.name == 'body')
    get_parent_div(paragraph.parent)
  end
end
