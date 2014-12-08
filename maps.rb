class Maps

  attr_reader :lat, :lon

  def initialize(query)
      @query = query

      get_location
  end

  def call_google_places_api(url)
          json_response = HTTParty.get(url).body
          return JSON.parse( json_response )
  end

  def get_location
      @query.gsub!(' ','%20')
      puts @query

      url = "https://maps.googleapis.com/maps/api/geocode/json?address="+@query+""

      parsed_result = call_google_places_api(url)
      #pp parsed_result

      #pp parsed_result
      parsed_result['results'].each do |result|
  	      x = result['geometry']['location']
          @lat = x['lat']
          @lon = x['lng']
          # puts @lat
          # puts @lon
      end
   end
end

# class Weathers

#   attr_reader :lat, :lon, :weatherStatus

#   def initialize(lat, lon)
#       @lat = lat
#       @lon = lon

#       display_weather
#   end

#   def call_open_weather_api(url)
#           json_response = HTTParty.get(url).body
#           return JSON.parse( json_response )
#   end

#   def display_weather

#     # url = "http://api.openweathermap.org/data/2.5/weather?lat="+@lat+"&lon="+@lon
#     url = "http://api.openweathermap.org/data/2.5/weather?lat="+@lat+"&lon="+@lon+"&type=like&units=imperial"

#     parsed_weather_result = call_open_weather_api(url)

#     parsed_weather_result['weather'].each do |result|
#         @description = result['description']
#     end

#     temp = parsed_weather_result['main']['temp']

#     @weatherStatus = "It is currently #{temp} and #{@description} outside."

#   end
# end


# post '/maps' do
#   @query = params[:locationinput]
#   @mile = params[:radius]
#   #@button = params[:button]
#
#   settings = Maps.new(@query, @mile)
#
#   @lat = settings.lat.to_s
#   @lon = settings.lon.to_s
#
#   place = Places.new(@lat, @lon)
#
#   @address = place.address
#   @phone_number = place.phone_number
#   @name = place.name
#   @rating = place.rating
#   @placeid = place.placeid
#   @addressformat = @address.gsub(' ','+')
#   @open_now = place.open_now
#
#   # weather = Weathers.new(@lat, @lon)
#
#   # @weatherStatus = weather.weatherStatus
#
#   erb :restaurant
#   puts "IN MAPS!!!!!"
#   pp params
#   puts "leaving maps!!!"
# end
#
# get '/places' do
#   @lat = params[:lat]
#   @lon = params[:lon]
#
#   place = Places.new(@lat, @lon)
#
#   @address = place.address
#   @phone_number = place.phone_number
#   @name = place.name
#   @rating = place.rating
#   @placeid = place.placeid
#   @addressformat = @address.gsub(' ','+')
#   @open_now = place.open_now
#
#   # weather = Weathers.new(@lat, @lon)
#
#   # @weatherStatus = weather.weatherStatus
#
#   erb :restaurant
# end
