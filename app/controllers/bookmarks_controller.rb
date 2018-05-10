class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def edit; end

  def create
    Bookmark.create(bookmark_params)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :description, :media_type, :fields)
  end
end
