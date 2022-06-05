class CreateBookmarkReaderViewJob < ApplicationJob
  queue_as :default

  def perform(document_body:, bookmark:)
    text = BodyTextParser.new(document_body).document_body
    bookmark.create_reader_view!(content: text)
  end
end
