module LunarSword
  describe Room do
    it 'has a description' do
      r = Room.new 'description' => 'A room'

      expect(r.description).to eq 'A room'
    end

    it 'has exits' do
      r = Room.new 'description' => 'Another room', 'exits' => ['W']

      expect(r.exits.first).to eq 'W'
    end
  end
end
