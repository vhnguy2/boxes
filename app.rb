$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "dao")

require "dao/game"

require "sinatra/base"

module Boxes
  class WebApp < Sinatra::Base
  
    get "/" do
      redirect "/main"
    end

    get "/main" do
      erb :main, :locals => { :variable => "I'm a noob...." }
    end

    get "/game/:game_id" do
      game = Boxes::DAO::Game.get(params[:game_id])
      erb :square, :locals => { 
        :home_team     => game[:home],
        :away_team     => game[:away],
        :time          => game[:time],
        :square_values => game[:square_values],
        :game_id       => params[:game_id]
      }
    end

    post "/game/submit/:game_id" do
      body = request.body.read
      puts body.inspect
      cells = body.split("\n")
      user = cells[0]
      cells = cells[1..-1]
      # write to disk
      Boxes::DAO::Game.save(params[:game_id], cells, user)
      [200]
    end

  end
end
