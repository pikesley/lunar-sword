require 'sinatra/base'
require 'tilt/erubis'
require 'json'
require 'yaml'
require 'matrix'

require_relative 'lunar_sword/helpers'
require_relative 'lunar_sword/racks'
require_relative 'lunar_sword/room'
require_relative 'lunar_sword/dungeon'
require_relative 'lunar_sword/explorer'
require_relative 'lunar_sword/item_list'
require_relative 'lunar_sword/item'

module LunarSword
  class App < Sinatra::Base
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

      @room = room params

      respond_to do |wants|
        wants.html do
          @title = @room.description
          @github_url = CONFIG['github_url']
          [300, erb(:room)]
        end

        wants.json do
          [
            300,
            {
              x: params[:x],
              y: params[:y],
              room: @room.description,
              exits: @room.exits
            }.to_json
          ]
        end
      end
    end

    post '/:x/:y/?' do
      headers 'Vary' => 'Accept'

      @room = room params
      @data = JSON.parse request.body.read

      case @data.keys.first
      when 'direction'
        next_room = {
          x: params[:x].to_i,
          y: params[:y].to_i
        }

        case @data['direction']
        when 'N'
          next_room[:y] -= 1
        when 'E'
          next_room[:x] += 1
        when 'S'
          next_room[:y] += 1
        when 'W'
          next_room[:x] -= 1
        end

        "/#{next_room[:x]}/#{next_room[:y]}"

      when 'take'
        explorer.take @data['take']
        @room.give_up @data['take']

        "/#{params[:x]}/#{params[:y]}"

      when 'drop'
        explorer.drop @data['drop']
        @room.receive @data['drop']

        "/#{params[:x]}/#{params[:y]}"
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
