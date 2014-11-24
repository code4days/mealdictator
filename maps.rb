class maps

def call_google_places_api(url)
        json_response = HTTParty.get(url).body
        return JSON.parse( json_response )
end

  def initialize(query, mile)
    @query = saasfd
    @mile = adfs

    parse_maps

  end

def parse_maps
    @query.gsub!(' ','%20')

    url = "https://maps.googleapis.com/maps/api/geocode/json?address="+@query+""

    parsed_result = call_google_places_api(url)

    #pp parsed_result
    parsed_result['results'].each do |result|
	x = result['geometry']['location']
        @lat = x['lat']
        @lon = x['lng']
    end
end

post '/maps' do
  @query = params[:locationinput]
  @mile = params[:mile]
  
  erb :value
end

end
