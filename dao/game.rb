module Boxes
  module DAO
    class Game
      
      # This is a temporray thing, use a real DB
      DATA_LOCATION=File.join(File.dirname(__FILE__), "..", "data")

      def self.save(game_id, cells, user)
        File.open("#{DATA_LOCATION}/#{game_id}_values", "a+") do |f|
          cells.each do |cell|
            f.write("#{cell} #{user}\n")
          end
        end
      end

      def self.get(game_id) 
        f = File.new("#{DATA_LOCATION}/#{game_id}_meta", "r")
        v_f = File.new("#{DATA_LOCATION}/#{game_id}_values", "r")
        values = Hash.new
        
        # populate the 2-level hash with the values of the squares
        while(line = v_f.gets)
          r, c, person = line.split(" ")
          values[r.to_i] ||= Hash.new
          values[r.to_i][c.to_i] = person
        end

        # return a hash with all of the data about this square
        {
          :home          => f.gets,
          :away          => f.gets,
          :time          => Time.parse(f.gets),
          :square_values => values
        }
      end
    end
  end
end
