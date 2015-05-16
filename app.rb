require 'json'
require 'sinatra'
require_relative 'lib/snippet'

post '/exec' do
  content_type :json

  payload = JSON.parse(request.body.read)
  logger.info payload

  file_name = payload['file_name']
  file_content = payload['file_content']

  success, output = Snippet.new(file_name, file_content).execute
  { success: success, output: output }.to_json
end  

