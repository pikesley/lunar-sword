module LunarSword
  class ItemList
    def initialize yaml_path
      @items = {}

      YAML.load_file(yaml_path).map { |i| @items[i['id']] = Item.new i }
    end

    def [] key
      @items[key]
    end
  end
end
