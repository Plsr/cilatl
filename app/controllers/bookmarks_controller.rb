class BookmarksController < ApplicationController
  before_action :require_login
  before_action :scrub_fields_array, only: [:create, :update], if: -> { has_fields_param? }
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

  def create
    merged_params = bookmark_params.merge(user: current_user)
    @bookmark = Bookmark.new(merged_params)

    if @bookmark.save
      redirect_to @bookmark
    else
      render "new"
    end
  end

  def update
    @bookmark = current_user.bookmarks.find(params[:id])
    if @bookmark.update_attributes(bookmark_params)
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

  def archive
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.archived? ? @bookmark.unarchive : @bookmark.archive
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :link, :description, :media_type, fields: [])
  end

  def scrub_fields_array
    params[:bookmark][:fields].delete_if(&:blank?)
  end

  def has_fields_param?
    params[:bookmark].present? && params[:bookmark][:field].present?
  end
end
