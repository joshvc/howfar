class PagesController < ApplicationController

  def index
  end

  def search
    @query = params[:query]
    link = URI.escape("http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@query}&destinations=
      Atlanta+GA
      |Orlando+FL
      |Charleston+SC
      |Denver+CO
      |Washington+DC
      |New+Orleans+LA
      |New+York+NY
      |Asheville+NC
      |Chicago+IL
      |Indianapolis+IN
      |Jackson+WY
      |Miami+FL
      |Los+Angeles+CA
      |Phoenix+AZ
      |Austin+TX
      |San+Francisco+CA
      |Portland+OR
      |Las+Vegas+NV
      |Nashville+TN
       &sensor=false&units=imperial")
    results = HTTParty.get(link)
    @starting = results["origin_addresses"].first
    @destinations = results["destination_addresses"]
    @distances = results["rows"][0]["elements"]

  end
end