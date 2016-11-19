module LunarSword
  class Item
    attr_reader :id, :full_name, :thwarts, :reusable, :used, :carriable

    def initialize data
      @data = data
      @id = data['id']
      @full_name = data['full_name']
      @thwarts = data['thwarts']
      @reusable = data['reusable']
      @carriable = data['carriable']
    end

    def use
      unless @reusable
        @used = true
      end
    end
  end
end
