require 'HTTParty'
require 'sinatra'
require 'json'

get '/' do
	bills = []
	erb :index2, locals: {list: bills}
end

# filtering: /legislators?last_name=Smith
# /legislators?apikey=[your_api_key]
# API Key: 4243e2a472ab45479bf32e120874550e


get '/button_click' do
	last_name = params['senator']
	# first_letter = last_name[0].upcase
	# last_name = last_name.splice(0, first_letter)
	sunlight_response = HTTParty.get("http://congress.api.sunlightfoundation.com/legislators?last_name=" + last_name + "&apikey=4243e2a472ab45479bf32e120874550e")
	bioguide_id = sunlight_response["results"][0]["bioguide_id"]
	bills_response = HTTParty.get("https://congress.api.sunlightfoundation.com/bills?sponsor_id=" + bioguide_id + "&history.active=true&order=last_action_at&apikey=4243e2a472ab45479bf32e120874550e")
	bills = []
	counter = 0
	while counter < 10 do 
		bill = bills_response["results"][counter]["short_title"]
		bills.push(bill)
		counter += 1
	end
	erb :index2, locals: {list: bills}
end