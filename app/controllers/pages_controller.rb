class PagesController < ApplicationController

  def index
  end

  def search
    @origin = params[:query].titleize
    case params[:list]
    when 'cities'
      @segments = Segment.create_from_cities(params[:query])
    when 'parks'
      @segments = Segment.create_from_national_parks(params[:query])
    end
  end
end