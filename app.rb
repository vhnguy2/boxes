$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "dao")

require "dao/game"

require "sinatra/base"

module Boxes
  class WebApp < Sinatra::Base
  
    get "/" do
      redirect "/main"
    end

    get "/main" do
      erb :main, :locals => { :variable => "I'm a noob" }
    end

    get "/game/:game_id" do
      game = Boxes::DAO::Game.get(params[:game_id])
      erb :square, :locals => { 
        :home_team     => game[:home],
        :away_team     => game[:away],
        :time          => game[:time],
        :square_values => game[:square_values]
      }
    end

  end
end
