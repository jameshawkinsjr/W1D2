require_relative 'tile.rb'
require_relative 'board.rb'

class Game
    attr_accessor :board

    def initialize
        @board = Board.new
    end

    def play
        #@board.render
        debugger
        until solved?
            pos_value = take_turn #pos_value example [[0,0], 5]

            if valid_move?(pos_value)
                pos = pos_value[0]
                value = pos_value[1]
                @board[pos] = value
            else
                puts "Make valid guess"
                next
            end

            @board.render
        end

        game_over
    end

    def take_turn
        puts "Please enter the row and colum number you would like to change"
        pos = gets.chomp.split(',').map {|ele| ele.to_i}

        puts "Please enter a number between 1 and 9"
        guess = gets.chomp.to_i

        [pos, guess]
    end

    def solved?
        completed = (1..9).to_a

        [rows + cols + quads].all? do |set|
            set.sort == completed
        end
    end

    def valid_move?(pos_value)
        pos = pos_value[0]
        value = pos_value[1]

        value < 10 && 
        pos.all? {|num| num < 9} && 
        @board[pos].provided == false
    end
        
    def game_over
        puts "You solved it!"
    end

    private

    def rows
        @board
    end

    def cols
        @board.transpose
    end

    def quads
        all_quads = []
        (0..2).each do |i|
            all_quads << @board[i][0..2] + @board[i][0..2] + @board[i][0..2]
        end

        (3..5).each do |i|
            all_quads << @board[i][3..5] + @board[i][3..5] + @board[i][3..5]
        end

        (6..8).each do |i|
            all_quads << @board[i][6..8] + @board[i][6..8] + @board[i][6..8]
        end

        all_quads    
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "Lets play sudoku! Please kill me."
    Game.new.play
end