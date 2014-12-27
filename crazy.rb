require 'httparty'
def call_google_places_api(url)

  json_response = HTTParty.get(url).body
  return JSON.parse( json_response )
end

details_url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJV0NDSTZaQIgR6LAM3obIkpI&key=AIzaSyB3xKb4v0cK805_F1ApSX0Os0KS-XzDoO4"
details_result = call_google_places_api(details_url)

puts (details_result['result']['opening_hours']['periods'])[0]

