class BookmarksController < ApplicationController
  before_action :require_login

  def new
    @bookmark = Bookmark.new
  end

  def show
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def edit
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def index
    @bookmarks = current_user.bookmarks.unarchived.limit(20)
  end

  def archive
    @bookmarks = current_user.bookmarks.archived.limit(20)
  end

  def build_from_url
    url = params[:url]
    meta_data = MetaData.new(url).page
    @bookmark = Bookmark.new({
      title: meta_data[:title],
      description: meta_data[:description],
      link: meta_data[:link],
      tag_names: meta_data[:fields].split(',').map(&:strip)
    })

    @page_content = meta_data[:page]
    render 'new'
  end

  def create
    merged_params = bookmark_params.merge(user: current_user)
    @bookmark = Bookmark.new(merged_params)
    @bookmark.tag_names = tag_names_array

    if @bookmark.save
      redirect_to @bookmark
    else
      render "new"
    end
  end

  def update
    @bookmark = current_user.bookmarks.find(params[:id])
    merged_params = bookmark_params.merge(tag_names: tag_names_array)
    if @bookmark.update_attributes(merged_params)
      redirect_to @bookmark
    else
      render "new"
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end

  def archivate
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.archived? ? @bookmark.unarchive : @bookmark.archive
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :link, :description, :media_type_id, :fields_list, :tags_string)
  end

  def tag_names_array
    bookmark_params[:tags_string].split(',').map(&:strip)
  end
end
