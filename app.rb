require 'json'
require 'sinatra'

post '/exec' do
  content_type :json
  payload = JSON.parse(request.body.read)
  logger.info payload
  { success: true, output: 'Done' }.to_json
end  
