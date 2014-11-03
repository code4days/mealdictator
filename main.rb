require 'sinatra'
require 'sinatra/reloader' if development?
require 'geocoder'


get '/' do
  "What's For Lunch on Sinatra!"
end

get '/geolocation' do

  city = request.location
  country = request.location.country_code

  "City: #{city}. Country: #{country}"

end