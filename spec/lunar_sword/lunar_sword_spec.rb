module LunarSword
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    it 'returns 300' do
      get '/0/0'
      expect(last_response.status).to eq 300
    end

    context 'exploring' do
      specify 'we move into the correct room' do
        post '/0/0', { direction: 'E'}.to_json, JSON_HEADERS
        get last_response.body
        expect(last_response.body).to match /You are in the north chamber/
      end

      specify 'we cannot jump around like this is Portal' do
        get '/0/0'
        get '/2/2'

        get last_response.header['Location']
        expect(last_response.body).to match /You have died by cheating/
      end
    end
  end
end
