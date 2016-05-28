require 'sinatra'
#require 'sinatra/reloader' if development?
#require 'json'
require 'httparty'
require './places'
require './maps'
require './weathers'
require 'pp'
# require './db'

configure do
  set :root, File.dirname(__FILE__)
  set :public_folder, "public/app"
end

get '/' do

File.read("public/app/index.html")

end

get '/.well-known/acme-challenge/:id' do

"YdckkOYhc28cP0ugn3JwDRPTh-bnawJ2e9ZDBSpy56M.-UoHTrge-mXXavQ8aYtOhEYdvB2ZXHoqKXfHqlwppnc"

end



get '/environment' do
  if development?
    "development"
  elsif production?
    "production"
  elsif test?
    "test"
  else
    "I don't know where the hell you are!"
  end
end
