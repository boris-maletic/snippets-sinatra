RSpec.describe '/exec', type: :request do
  it 'works for Ruby "Hello, world application"' do
    code = 'puts "Hello, world!"'
    post '/exec', { file_name: 'ruby.rb', file_content: code }.to_json
    expect(last_response).to be_ok
    expect(last_response.body).to eq({ success: true, output: "Hello, world!\n"}.to_json)
  end
end

