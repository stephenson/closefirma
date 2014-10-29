require 'sinatra'
require 'rest-client'
require 'uri-handler'

api_url = "https://app.close.io/api/v1"

get '/' do
  erb :index
end

post '/install' do
  name = "Close.io".to_uri
  url = "#{request.env['rack.url_scheme']}://#{request.host}/iframe/#{params[:api_key]}".to_uri

  redirect to("https://app.firmafon.dk/integrations/new?provider=iframe&name=#{name}&url=#{url}")
end

get '/iframe/:apikey' do

  num = params[:number].to_uri

  @leads = JSON.parse(RestClient.get("https://#{params[:apikey]}:@app.close.io/api/v1/lead/",
                                 {:params => {:query => "phone_number:+"+num},
                                  :accept => :json}))

  erb :iframe

end