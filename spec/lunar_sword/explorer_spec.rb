module LunarSword
  describe Explorer do
    it 'can carry items' do
      e = Explorer.new
      e.take 'shovel'
      expect(e.items.first).to eq 'shovel'
    end

    it 'can drop items' do
      e = Explorer.new
      e.take 'koala'
      e.take 'wombat'

      e.drop 'koala'
      expect(e.items.first).to eq 'wombat'
    end

    specify 'items are unique' do
      e = Explorer.new
      e.take 'coin'
      e.take 'coin'

      expect(e.items.count).to eq 1
    end

    it 'cleans out an empty list' do
      e = Explorer.new
      e.take 'coin'
      e.drop 'coin'

      expect(e.items.count).to eq 0
    end
  end
end
