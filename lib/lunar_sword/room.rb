module LunarSword
  class Room
    attr_reader :items

    def initialize data
      @data = data
      @items = data['items'] || []
    end

    def method_missing m, *args
      @data[m.to_s]
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
