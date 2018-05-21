class PagesController < ApplicationController
  def index; end
  def find
    @fields = current_user.fields
  end
end
