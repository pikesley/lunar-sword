module LunarSword
  class Item
    attr_reader :used

    def initialize data
      @data = data
    end

    def method_missing m, *args
      @data[m.to_s]
    end

    def use
      unless @reusable
        @used = true
      end
    end
  end
end
