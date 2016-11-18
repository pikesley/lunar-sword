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

    it 'has items' do
      r = Room.new 'items' => ['paint brush']

      expect(r.items.first).to eq 'paint brush'
    end

    it 'can yield items' do
      r = Room.new 'items' => ['cactus']
      r.give_up 'cactus'

      expect(r.items).to eq []
    end

    it 'can receive items' do
      r = Room.new 'description' => 'Room without a tiger'
      r.receive 'tiger'

      expect(r.items.first).to eq 'tiger'
    end

    it 'cleans out an empty list' do
      e = Room.new 'items' => ['velociraptor']
      e.give_up 'velociraptor'

      expect(e.items.count).to eq 0
    end
  end
end
