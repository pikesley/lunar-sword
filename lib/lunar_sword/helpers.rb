module LunarSword
  CONFIG = YAML.load_file('config/config.yml') || {}

  module Helpers
    def location params
      $dungeon[params['x'].to_i, params['y'].to_i]
    end
  end
end
