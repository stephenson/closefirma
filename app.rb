require 'sinatra'
require 'rest-client'
require 'uri-handler'

api_url = "https://app.close.io/api/v1"

configure do
    set :protection, except: [:frame_options]
end

get '/' do
  erb :index
end

post '/install' do
  name = "Close.io".to_uri
  url = "https://#{request.host}/iframe/#{params[:api_key]}".to_uri
  description = "Vis leads fra Close.io direkte i Firmafon".to_uri
  icon = "http://close.io/static/img/new_logo_only_80.png".to_uri

  if Sinatra::Base.development?
    server = "http://localhost:3000"
  else
    server = "https://app.firmafon.dk"
  end

  redirect to("#{server}/integrations/new?provider=external_app&name=#{name}&url=#{url}&description=#{description}&icon=#{icon}")
end

get '/iframe/:apikey' do

  num = params[:number].to_uri

  @leads = JSON.parse(RestClient.get("https://#{params[:apikey]}:@app.close.io/api/v1/lead/",
                                 {:params => {:query => "phone_number:+"+num},
                                  :accept => :json}))

  erb :iframe

end