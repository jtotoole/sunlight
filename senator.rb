require 'HTTParty'
require 'sinatra'
require 'json'

get '/' do
	twitter = ""
	erb :index, locals: {handle: twitter}
end

# filtering: /legislators?last_name=Smith
# /legislators?apikey=[your_api_key]
# API Key: 4243e2a472ab45479bf32e120874550e


get '/button_click' do
	last_name = params['senator']
	# first_letter = last_name[0].upcase
	# last_name = last_name.splice(0, first_letter)
	sunlight_response = HTTParty.get("http://congress.api.sunlightfoundation.com/legislators?last_name=" + last_name + "&fields=twitter_id&apikey=4243e2a472ab45479bf32e120874550e")
	twitter = sunlight_response["results"][0]["twitter_id"]
	erb :index, locals: {handle: twitter}
end