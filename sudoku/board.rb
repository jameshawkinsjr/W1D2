require_relative 'tile'

require 'byebug'

class Board
    attr_accessor :grid, :make_grid

    def self.make_grid
        
        layout = File.readlines("sudoku1.txt", chomp: true)
        layout.map! do |row|
            row.split("")
        end

        layout.map! do |row|
            row.map! do |col|
                Tile.new(col.to_i)
            end
        end
        print layout
    end

    def intialize
        @grid = Board.make_grid
    end

    def render
        # system("clear")
        height = 9
        puts "The numbers in [] are permanent"
        
        print "  "
        
        (0..height - 1).each {|i| print "  #{i} "}
        
        height.times.with_index do |row, row_idx|
            puts
            print "#{row_idx} "
            height.times.with_index do |column, col_idx|
                pos = [row_idx, col_idx]
                debugger
                tile = self[pos]
                print "#{tile}"
            end
        end
        puts
    end

    def [](pos) # board[pos]
        #byebug
        row, col = pos
        grid[row][col]
    end

    def []=(pos, value) # board[pos] = _____
        row, col = pos
        grid[row][col].value = value
    end

end