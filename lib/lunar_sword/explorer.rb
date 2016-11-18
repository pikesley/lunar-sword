module LunarSword
  class Explorer
    attr_reader :items

    def initialize
      @items = []
    end

    def take(item)
      @items.push item
      @items.uniq! { |i| i.id }
    end

    def drop(item)
      @items.delete_if { |i| i.id == item }
    end
  end
end
