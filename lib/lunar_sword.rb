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
      session.clear

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

      @valid_neighbours = @room.exits.map { |e| next_room params[:x].to_i, params[:y].to_i, e }
      @valid_neighbours.push "/#{params[:x]}/#{params[:y]}"

      if session[:source_room]
        unless @valid_neighbours.include? session[:source_room]
          session[:flash] = 'You have died by cheating'
          redirect to '/dead'
        end
      end

      session[:source_room] = "/#{params[:x]}/#{params[:y]}"

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
        next_room params[:x].to_i, params[:y].to_i, @data['direction']

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

    get '/dead' do
      respond_to do |wants|
        wants.html do
          @title = 'Dead'
          @github_url = CONFIG['github_url']
          @cause = session[:flash]
          [410, erb(:dead)]
        end

        wants.json do
          [
            410,
            {
              dead: 'you',
              cause: session[:flash]
            }.to_json
          ]
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
