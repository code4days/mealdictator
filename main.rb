require 'sinatra'
require 'sinatra/reloader' if development?
require 'google_places'


get '/' do
  "What's For Lunch on Sinatra!"
end

get '/geo' do
  
  @client = GooglePlaces::Client.new("AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4")

  lat = 151.1957362
  lon = -33.8670522


  @spots_list = @client.spots(lon, lat, :types => 'restaurant')

  erb :geo


end