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

    it 'knows its coordinates' do
      r = Room.new 'description' => 'Room with a view',
                   'x' => 0,
                   'y' => 1

      expect(r.x).to eq 0
    end
  end
end
