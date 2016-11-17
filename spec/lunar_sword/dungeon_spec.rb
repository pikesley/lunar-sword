module LunarSword
  describe Dungeon do
    it 'has rooms' do
      d = Dungeon.new 'config/dungeon.yml'

      expect(d[0, 0].description).to eq 'north west'
    end

    it 'has the correct rooms' do
      d = Dungeon.new 'config/dungeon.yml'

      expect(d[1, 0].description).to eq 'north east'
    end
  end
end
