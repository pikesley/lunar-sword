module LunarSword
  class Explorer
    attr_reader :items

    def initialize
      @items = []
    end

    def take(item)
      @items.push item
      @items.uniq!
    end

    def drop(item)
      @items.delete item
    end
  end
end
