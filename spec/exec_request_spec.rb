RSpec.describe '/exec', type: :request do
  it 'works for Ruby "Hello, world application"' do
    post '/exec', { language: 'Ruby', code: 'puts "Hello, world!"' }.to_json
    expect(last_response).to be_ok
  end
end
