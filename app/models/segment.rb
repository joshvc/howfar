class Segment
  attr_accessor :destination
  attr_accessor :distance
  attr_accessor :drive_time
  attr_accessor :distance_value
  attr_accessor :origin

  def self.create_from_cities(query)
    link = URI.escape("http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{query}&destinations=
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
      |Montreal+QC
      |Toronto+ON
      |Huntsville+AL
      |Greenville+SC
       &sensor=false&units=imperial")
    results = HTTParty.get(link)
    payload = []
    results["destination_addresses"].count.times do |i|
      s = Segment.new
      s.destination = results["destination_addresses"][i]
      s.distance = results["rows"][0]["elements"][i]["distance"]["text"]
      s.drive_time = results["rows"][0]["elements"][i]["duration"]["text"]
      s.distance_value = results["rows"][0]["elements"][i]["distance"]["value"]
      s.origin = results["origin_addresses"][0]
      payload << s
    end
    return payload.sort{|a,b| a.distance_value <=> b.distance_value}
  end

  def map_link
    "https://maps.google.com/maps?saddr=#{origin.gsub(" ", "+")}&daddr=#{destination.gsub(" ", "+")}"
  end
end