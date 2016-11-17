require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'matrix'

require_relative 'lunar_sword/helpers'
require_relative 'lunar_sword/racks'
require_relative 'lunar_sword/room'
require_relative 'lunar_sword/dungeon'

module LunarSword
  class App < Sinatra::Base
    $dungeon = YAML.load_file 'config/dungeon.yml'

    helpers do
      include LunarSword::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          @content = '<h1>Hello from LunarSword</h1>'
          @title = 'LunarSword'
          @github_url = CONFIG['github_url']
          erb :index
        end

        wants.json do
          {
            app: 'LunarSword'
          }.to_json
        end
      end
    end

    get '/:x/:y' do
      headers 'Vary' => 'Accept'

      @location = $dungeon[params['x'].to_i][params['y'].to_i]

      respond_to do |wants|
        wants.html do
          @title = @location['description']
          erb :room
        end
      end
    end

    # start the server if ruby file executed directly
    run! if app_file == $0

    not_found do
      status 404
      @title = '404'
      erb :oops
    end
  end
end
