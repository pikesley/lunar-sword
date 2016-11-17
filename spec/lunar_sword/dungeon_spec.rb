module LunarSword
  describe Dungeon do
    it 'has rooms' do
      d = Dungeon.new 'config/dungeon.yml'

      expect(d[0, 0].description).to eq 'North west'
    end
  end
end
