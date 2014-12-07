class Places

  attr_reader :address, :phone_number, :name, :rating, :placeid, :open_now, :periods

  def initialize(lat, lon)
    @lat = lat
    @lon = lon

    parse_nearby_restaurants

  end

  def call_google_places_api(url)

    json_response = HTTParty.get(url).body
    return JSON.parse( json_response )
  end

  def parse_nearby_restaurants

    restaurants = Hash.new()

    #do a places search to get the name of restaurants and their place_id within a given radius
    #search_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+ @lat + "," + @lon + "&radius=1000&types=food&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4"
    search_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants&location="+ @lat + "," + @lon + "&radius=1000&types=restaurant&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4"


    parsed_result = call_google_places_api(search_url)

    pp parsed_result

    parsed_result['results'].each do |result|

      restaurants[result['name']] = result['place_id']

    end

    place_id = restaurants[restaurants.keys.sample]

    #do a details search to retrieve details about the selected location
    details_url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + place_id + "&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4"

    details_result = call_google_places_api(details_url)

    if details_result['result']['formatted_address'] != nil
      @address = details_result['result']['formatted_address']
    end

    if details_result['result']['place_id'] != nil
      @placeid = details_result['result']['place_id']
    end

    if details_result['result']['formatted_phone_number'] != nil
      @phone_number = details_result['result']['formatted_phone_number']
    end

    if details_result['result']['name'] != nil
      @name = details_result['result']['name']
    end

    if  details_result['result']['rating'] != nil
      @rating = details_result['result']['rating']
    end

    if  details_result['result']['opening_hours']['open_now'] != nil
      if details_result['result']['opening_hours']['open_now'] == true
        @open_now = "Open now"
      else
        @open_now = "Closed"
      end
    else
        @open_now = "No data"
    end

    if details_result['result']['opening_hours']['periods'][Time.now.wday] != nil
	@periods = details_result['result']['opening_hours']['periods'][Time.now.wday]
	@periods = Time.parse(@periods['open']['time'].insert(2,":")).strftime("%I:%M%p")+ " - " + Time.parse(@periods['close']['time'].insert(2,":")).strftime("%I:%M%p")
    end

  end
end


class Maps

  attr_reader :lat, :lon

  def initialize(query, mile)
      @query = query
      @mile = mile

      parse_maps
  end

  def call_google_places_api(url)
          json_response = HTTParty.get(url).body
          return JSON.parse( json_response )
  end

  def parse_maps
      @query.gsub!(' ','%20')
      puts @query

      url = "https://maps.googleapis.com/maps/api/geocode/json?address="+@query+""

      parsed_result = call_google_places_api(url)
      pp parsed_result

      #pp parsed_result
      parsed_result['results'].each do |result|
  	x = result['geometry']['location']
          @lat = x['lat']
          @lon = x['lng']
          puts @lat
          puts @lon
      end
   end
end

class Weather

  def initialize(lat, lon)
      @lat = lat
      @lon = lon

      display_weather
  end

  def call_google_places_api(url)
          json_response = HTTParty.get(url).body
          return JSON.parse( json_response )
  end

  def display_weather

  url = "api.openweathermap.org/data/2.5/weather?lat="+@lat+"&lon="+@lon

  parsed_weather_result = call_google_places_api(url)
  pp parsed_weather_result
  end

end


get '/maps' do
  @query = params[:locationinput]
  @mile = params[:mile]
  #@button = params[:button]

  settings = Maps.new(@query, @mile)

  @lat = settings.lat.to_s
  @lon = settings.lon.to_s

  place = Places.new(@lat, @lon)
#  weather = Weather.new(@lat, @lon)

#  @weather =
  @address = place.address
  @phone_number = place.phone_number
  @name = place.name
  @rating = place.rating
  @placeid = place.placeid
  @addressformat = @address.gsub(' ','+')
  @open_now = place.open_now
  @periods = place.periods
  erb :restaurant
end

get '/places' do
  @lat = params[:lat]
  @lon = params[:lon]

  place = Places.new(@lat, @lon)

  @address = place.address
  @phone_number = place.phone_number
  @name = place.name
  @rating = place.rating
  @placeid = place.placeid
  @addressformat = @address.gsub(' ','+')
  @open_now = place.open_now
  erb :restaurant
end
