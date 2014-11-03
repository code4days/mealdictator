require 'sinatra'
require 'sinatra/reloader' if development?
require 'geocoder'

get '/geolocation' do

  city = request.location
  country = request.location.country_code

  "City: #{city}. Country: #{country}"

end