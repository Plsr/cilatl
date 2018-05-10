class BookmarksController < ApplicationController
  before_action :scrub_fields_array, only: [:create, :update], if: -> { :has_fields_param? }
  def new
    @bookmark = Bookmark.new
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def index
    @bookmarks = Bookmark.all.limit(20)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark
    else
      render "new"
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update_attributes(bookmark_params)
      redirect_to @bookmark
    else
      render "new"
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :description, :media_type, fields: [])
  end

  def scrub_fields_array
    params[:bookmark][:fields].delete_if(&:blank?)
  end

  def has_fields_param?
    params[:bookmark] && params[:bookmark][:field]
  end
end
