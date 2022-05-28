class BookmarksController < ApplicationController
  before_action :require_login

  def new
    @bookmark = Bookmark.new
  end

  def show
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def index
    @bookmark = Bookmark.new
    @bookmarks = current_user.bookmarks.unarchived
  end

  def archive
    @bookmarks = current_user.bookmarks.archived.limit(20)
  end

  def create
    # TODO: Do some validation on the link
    url = bookmark_params[:link]
    meta_data = MetaData.new(url)
    @bookmark = Bookmark.new({
      user: current_user,
      title: meta_data.page[:title],
      description: meta_data.page[:description],
      link: meta_data.page[:link],
      tag_names: build_tags(meta_data.page[:fields])
    })

    if @bookmark.save
      # TODO: Success flash
      # TODO: Switch to perform later
      CreateBookmarkReaderViewJob.new(document_body: meta_data.document_body, bookmark: @bookmark).perform_now
      redirect_to bookmarks_path
    else
      # TODO: Show errors here
      redirect_to bookmarks_path
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  def read
    @bookmark = Bookmark.find(params[:id])
    return head :unauthorized unless @bookmark.user == current_user
    @reader_view = @bookmark.reader_view
  end

  def archivate
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.archived? ? @bookmark.unarchive : @bookmark.archive
    redirect_to bookmarks_path
  end

  private

  def build_tags(meta_tags)
    return [] unless meta_tags
    meta_tags.split(',').map(&:strip)
  end

  def bookmark_params
    params.require(:bookmark).permit(:link)
  end

  def tag_names_array
    bookmark_params[:tags_string].split(',').map(&:strip)
  end
end
