require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'httparty'

get '/' do
  erb :home
end

get '/geo' do

  @lat = params[:lat]
  @lon = params[:lon]

  @restaurant = Hash.new()

  line = ""


  url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+ @lat + "," + @lon + "&radius=1000&types=food&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4"


  json_response = HTTParty.get(url).body
  parsed_result = JSON.parse(json_response )


  parsed_result['results'].each do |result|
    open_now = ""

    if result.include? "opening_hours"
      result['opening_hours']['open_now'] == true ? open_now = "Open" : open_now = "Closed"
    end

    @restaurant[result['name']] = open_now;
    @selected_restaurant = @restaurant.keys.sample

  end


  erb :geo
  # "latitude - #{lat} longitude - #{lon}"
end


get '/geo2' do
  line = ""


  url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.379686,-84.3879848&radius=1000&types=restaurant&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4'


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

get '/environment' do
  if development?
    "development"
  elsif production?
    "production"
  elsif test?
    "test"
  else
    "I don't know where the hell you are!"
  end
end
