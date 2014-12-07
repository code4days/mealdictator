class Places

  attr_reader :lat, :lon, :address, :phone_number, :name, :rating, :placeid, :open_now, :periods

  def initialize(lat, lon, radius=1600)
    @lat = lat
    @lon = lon
    @radius = radius

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
    search_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants&location=" + @lat.to_s + "," + @lon.to_s + "&radius=" + @radius.to_s + "&types=restaurant&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4"


    parsed_result = call_google_places_api(search_url)

    #pp parsed_result

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



get '/places' do
  lat = params[:lat]
  lon = params[:lon]


  @place = Places.new(lat, lon)

  # @address = place.address
  # @phone_number = place.phone_number
  # @name = place.name
  # @rating = place.rating
  # @placeid = place.placeid
  # @addressformat = @address.gsub(' ','+')
  # @open_now = place.open_now
  erb :restaurant
end

post '/places' do
  query = params[:locationinput]
  radius = params[:radius]


  settings = Maps.new(query)


  @place = Places.new(settings.lat, settings.lon, radius)

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

  erb :restaurant

   open_now = ""
  
   if result.include? "opening_hours"
     result['opening_hours']['open_now'] == true ? open_now = "Open" : open_now = "Closed"
   end
  
   @restaurant[result['name']] = open_now;
end
