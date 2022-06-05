class CreateBookmarkReaderViewJob < ApplicationJob
  queue_as :default

  def perform(bookmark:)
    document_body = MetaData.new(bookmark.link).document_body
    text = BodyTextParser.new(document_body).document_body
    bookmark.create_reader_view!(content: text)
  end
end
