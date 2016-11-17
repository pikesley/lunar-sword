module LunarSword
  class Room
    attr_reader :description, :exits

    def initialize data
      @description = data['description']
      @exits = data['exits'] || []
    end
  end
end
