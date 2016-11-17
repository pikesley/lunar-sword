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
    $dungeon = Dungeon.new 'config/dungeon.yml'

    enable :sessions

    helpers do
      include LunarSword::Helpers
    end

    get '/' do
      headers 'Vary' => 'Accept'

      respond_to do |wants|
        wants.html do
          redirect to '/0/0/'
        end

        wants.json do
          redirect to '/0/0/'
        end
      end
    end

    get '/:x/:y/?' do
      headers 'Vary' => 'Accept'

      @location = location params

      respond_to do |wants|
        wants.html do
          @title = @location.description
          @github_url = CONFIG['github_url']
          [300, erb(:room)]
        end

        wants.json do
          [
            300,
            {
              x: params[:x],
              y: params[:y],
              room: @location.description,
              exits: @location.exits
            }.to_json
          ]
        end
      end
    end

    get '/:x/:y/:direction/?' do
      headers 'Vary' => 'Accept'

      @location = location params

      unless @location.exits.include? params[:direction] then
        @title = @location.description
        session[:flash] = 'You cannot go that way!'
        redirect to "/#{params[:x]}/#{params[:y]}"
      end

      next_room = {
        x: params[:x].to_i,
        y: params[:y].to_i
      }

      case params[:direction]
      when 'N'
        next_room[:y] -= 1
      when 'E'
        next_room[:x] += 1
      when 'S'
        next_room[:y] += 1
      when 'W'
        next_room[:x] -= 1
      end

      redirect to "/#{next_room[:x]}/#{next_room[:y]}"
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
