# TODO: Move out of models, is a service
class MetaData
  CONFIG = { connection_timeout: 5, read_timeout: 5, retries: 1 }.freeze
  attr_reader :url, :service

  def initialize(url, service = MetaInspector)
    @url = url || ''
    @service = service
    @result = @service.new(url, CONFIG)
  end

  def document_body
    @result.parsed
  end

  def page
    {
      title: @result.title,
      description: @result.best_description,
      link: @result.url,
      fields: @result.meta['keywords'] || '',
    }
  rescue MetaInspector::TimeoutError, MetaInspector::RequestError, MetaInspector::ParserError
    Rails.logger.error("MetaInspector failed to load #{url}")
    {}
  end
end
