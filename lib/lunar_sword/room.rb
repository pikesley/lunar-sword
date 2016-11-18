module LunarSword
  class Room
    attr_reader :description,
                :exits,
                :x,
                :y,
                :items

    def initialize data
      @description = data['description']
      @exits = data['exits'] || []
      @x = data['x']
      @y = data['y']
      @items = data['items'] || []
    end

    def give_up item
      @items.delete item
    end

    def receive item
      @items.push item
      @items.uniq
    end
  end
end
