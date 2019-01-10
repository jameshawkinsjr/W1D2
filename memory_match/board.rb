require 'byebug'
require_relative 'card.rb'

class Board
    attr_reader :values
    attr_accessor :grid

    def self.make_grid(grid_width, values)
        pairs_needed = (grid_width ** 2) / 2
        letters_needed = values[0...pairs_needed]

        game_pairs = (letters_needed + letters_needed).shuffle!

        grid = Array.new(grid_width) {
            Array.new(grid_width) {Card.new(game_pairs.pop)} 
        }
    end

    def initialize(grid_width)
        @values = ('a'..'z').to_a
        @grid = Board.make_grid(grid_width, values)
    end

    def render(num_guesses=0)
        system("clear")

        height = @grid[0].length
        puts "@ symbol represents hidden card value"
        puts "You have made #{num_guesses} guesses"
        
        print "  "
        
        (0..height - 1).each {|i| print "  #{i} "}
        
        height.times.with_index do |row, row_idx|
            puts
            print "#{row_idx} "
            height.times.with_index do |column, col_idx|
                pos = [row_idx, col_idx]
                card = self[pos]
                print "#{card}"
            end
        end
        puts
    end

    def render_revealed_temporarily
        @grid.flatten.each { |card| card.face_up = true}
        self.render
        puts "Memorize the board! You have 3 seconds."
        sleep(3)
        @grid.flatten.each { |card| card.face_up = false}
    end

    def reveal(pos)
        self[pos].flip
    end

    def won?
        flattened = @grid.flatten

        flattened.all? {|card| card.matched == true}
    end

    def [](pos) # board[pos]
        row, col = pos
        return @grid[row][col]
    end

    def []=(pos, value) # board[pos] = _____
        row, col = pos
        @grid[row][col] = value
    end



end

