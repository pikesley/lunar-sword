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
  end
end
