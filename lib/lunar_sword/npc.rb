module LunarSword
  class NonPlayerCharacter
    attr_reader: words

    def initialize data
      @data = data
    end

    def method_missing m, *args
      @data[m.to_s]
    end
  end
end
