module LunarSword
  class Dungeon
    def initialize yaml_path
      data = YAML.load_file yaml_path
      @rooms = Matrix.rows(data).map do |d|
        Room.new d
      end
    end

    def [] x, y
      @rooms[x, y]
    end
  end
end
