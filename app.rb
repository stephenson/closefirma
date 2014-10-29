require 'sinatra'
require 'rest-client'
require 'uri-handler'

api_url = "https://app.close.io/api/v1"

get '/' do
  'Hello world!'
end

get '/iframe/:apikey' do

  num = params[:number].to_uri

  @leads = JSON.parse(RestClient.get("https://#{params[:apikey]}:@app.close.io/api/v1/lead/",
                                 {:params => {:query => "phone_number:+"+num},
                                  :accept => :json}))

  erb :iframe

end