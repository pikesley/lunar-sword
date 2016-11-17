module LunarSword
  JSON_HEADERS = { 'HTTP_ACCEPT' => 'application/json' }

  describe App do
    it 'returns 300' do
      get '/0/0'
      expect(last_response.status).to eq 300
    end
  end
end
