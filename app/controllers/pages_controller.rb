class PagesController < ApplicationController

  def index
  end

  def search
    @origin = params[:query].titleize
    @segments = Segment.create_from_cities(params[:query])
  end
end