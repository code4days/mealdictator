require 'httparty'
require 'json'
require 'pp'

def call_open_weather_api(url)
  json_response = HTTParty.get(url).body
  return JSON.parse(json_response)
end

def display_weather

  lat = "39.0307016"
  long = "-84.4666092"
  url = "http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+long+"&type=like&units=imperial"
  puts url
  parsed_weather_result = call_open_weather_api(url)


  parsed_weather_result['weather'].each do |result|
      @description = result['description']
  end



  temp = parsed_weather_result['main']['temp']
  puts "-\n"*5
  puts "It is currently #{temp} and #{@description} outside."
  puts "-\n"*5
  # pp parsed_weather_result
end

display_weather


