module LunarSword
  CONFIG = YAML.load_file('config/config.yml') || {}

  module Helpers
    def room params
      dungeon[params['x'].to_i, params['y'].to_i]
    end

    def dungeon
      session[:dungeon] || begin
        session[:dungeon] = Dungeon.new 'config/dungeon.yml'
        return session[:dungeon]
      end
    end

    def explorer
      session[:explorer] || begin
        session[:explorer] = Explorer.new
        return session[:explorer]
      end
    end

    def all_items
      session[:all_items] || begin
        session[:all_items] = ItemList.new 'config/items.yml'
        return session[:all_items]
      end
    end

    def all_npcs
      session[:all_npcs] || begin
        session[:all_npcs] = ItemList.new 'config/npcs.yml'
        return session[:all_npcs]
      end
    end

    def next_room x, y, direction

      case direction
      when 'N'
        y -= 1
      when 'E'
        x += 1
      when 'S'
        y += 1
      when 'W'
        x -= 1
      end

      "/#{x}/#{y}"
    end

    def slugify s
      s.gsub(' ', '-')
    end

    def points key
      {
        'N' => 'North',
        'E' => 'East',
        'S' => 'South',
        'W' => 'West'
      }[key]
    end

    def direction_button room, direction
      type = 'disabled'
      onclick = nil

      if room.exits.include? direction
        type = 'primary'
        onclick = "travel(\"#{direction}\")"
      end

      b = "<button id='#{points direction}' class='btn btn-#{type}'"
      b += " onclick='#{onclick}'" if onclick
      b += ">#{points direction}</button>"

      b
    end
  end
end
