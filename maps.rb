class maps

def call_google_places_api(url)
        json_response = HTTParty.get(url).body
        return JSON.parse( json_response )
end

  def initialize(query, mile, button)
    @query = saasfd
    @mile = adfs
    @button = submit

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

get '/maps' do
  @query = params[:locationinput]
  @mile = params[:mile]
  @button = params[:button]
  
  erb :value
end

end
