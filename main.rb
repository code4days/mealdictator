require 'sinatra'
require 'sinatra/reloader' if development?
require 'google_places'
require 'json'

get '/' do
  "What's For Lunch on Sinatra!"
end

get '/geo' do

  @client = GooglePlaces::Client.new("AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4")

  #lat = 39.3797966
  #lat = 39.379686
  #lon = -84.3886005
  #lon = -84.3879848

  lat = 151.1957362
  lon = -33.8670522


  @spots_list = @client.spots(lon, lat, :types => 'restaurant')

  erb :geo


end

get '/geo2' do
  line = ""


  url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.379686,-84.3879848&radius=1000&types=food&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4'


  json_response = HTTParty.get(url).body
  parsed_result = JSON.parse(json_response )


  parsed_result['results'].each do |result|
    open_now = ""

    if result.include? "opening_hours"
      result['opening_hours']['open_now'] == true ? open_now = "Open" : open_now = "Closed"
    end

    line += "#{result['name']} is currently #{open_now}<br/><br/>"

  end
  line
end
