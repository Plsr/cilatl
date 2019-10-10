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
      fields_list: meta_data[:fields]
    })
    render 'new'
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

  def archivate
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.archived? ? @bookmark.unarchive : @bookmark.archive
    redirect_to bookmarks_path
  end

  def filtered
    field = current_user.fields.find(params[:field])
    media_type = MediaType.find(params[:media_type])
    @bookmark = current_user.bookmarks.unarchived.where('media_type': media_type).order("random()").select { |b| b.fields.include?(field) }.first
    if @bookmark
      redirect_to @bookmark
    else
      flash[:warning] = 'No records found'
      redirect_to root_path and return
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :link, :description, :media_type_id, :fields_list)
  end

  def scrub_fields_array
    params[:bookmark][:fields_list].delete_if(&:blank?)
  end

  def has_fields_param?
    params[:bookmark].present? && params[:bookmark][:field].present?
  end
end
