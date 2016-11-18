module LunarSword
  describe ItemList do
    it 'has items' do
      il = ItemList.new 'spec/fixtures/config/items.yml'
      expect(il['bomb'].reusable).to be false
    end

    it 'has one-time-use items' do
      il = ItemList.new 'spec/fixtures/config/items.yml'

      il['bomb'].use

      expect(il['bomb'].used).to be true
    end
  end

  describe Item do
    it 'has attributes' do
      i = Item.new 'id' => 'shovel',
                   'full_name' => 'a shovel',
                   'thwarts' => 'rubble',
                   'reusable' => true

      expect(i.reusable).to be true
    end
  end
end
