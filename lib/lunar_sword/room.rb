module LunarSword
  class Room
    attr_reader :description, :exits, :x, :y

    def initialize data
      @description = data['description']
      @exits = data['exits'] || []
      @x = data['x']
      @y = data['y']
    end
  end
end
