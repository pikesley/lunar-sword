module LunarSword
  describe Explorer do
    it 'can carry items' do
      e = Explorer.new
      e.take Item.new 'id' => 'shovel'
      expect(e.items.first.id).to eq 'shovel'
    end

    it 'can drop items' do
      e = Explorer.new
      e.take Item.new 'id' => 'koala'
      e.take Item.new 'id' => 'wombat'

      e.drop 'koala'
      expect(e.items.first.id).to eq 'wombat'
    end

    specify 'items are unique' do
      e = Explorer.new
      e.take Item.new 'id' => 'coin'
      e.take Item.new 'id' => 'coin'

      expect(e.items.count).to eq 1
    end

    it 'cleans out an empty list' do
      e = Explorer.new
      e.take Item.new 'id' => 'coin'
      e.drop 'coin'

      expect(e.items.count).to eq 0
    end
  end
end
