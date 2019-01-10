require_relative 'card.rb'
require_relative 'board.rb'

class Game
    attr_accessor :board, :guess1, :guess2, :num_guesses
    
    # DELAY_TIME = 3 #seconds

    def initialize(width)
        @board = Board.new(width)
        @num_guesses = 0
    end

    def play
        @board.render_revealed_temporarily
        @board.render(@num_guesses)
        until @board.won?
            guessed_pair = take_turn # array of 2 card instances

            if !valid_move?(guessed_pair)
                move_was_invalid(guessed_pair)
                next
            end

            matched(guessed_pair)

            sleep(3)

            @board.render(@num_guesses)
        end
        game_over
    end

    def matched(guessed_pair)
        # comparing the value of these two card instances
        if guessed_pair[0] == guessed_pair[1] 
            puts "You found a match!"
            guessed_pair.each { |card| card.matched = true}
        else
            puts "These do not match"
            guessed_pair.each { |card| card.face_up = false}
        end
    end

    def take_turn # return pair of guesses
        @num_guesses += 1
        
        puts "guess your first card (format: row,col)"
        guess1 = gets.chomp # ex. '1,2'
        pos1 = guess_to_pos_and_render(guess1) # [1, 2]

        puts "guess your second card (format: row,col)"
        guess2 = gets.chomp
        pos2 = guess_to_pos_and_render(guess2) # [1, 2]

        [@board[pos1], @board[pos2]] # this is guesses_pair
    end

    def game_over
        puts "You found all of the matches!"
        puts "It took you #{num_guesses} guesses"
    end

    private

    def guess_to_pos_and_render(guess)
        pos = guess.split(',').map {|ele| ele.to_i}

        @board.reveal(pos)
        @board.render(@num_guesses)

        pos
    end

    def valid_move?(guessed_pair)
        guessed_pair.all? {|card| card.matched == false} && 
        guessed_pair[0].object_id != guessed_pair[1].object_id
    end

    def move_was_invalid(guessed_pair)
        puts "you guessed an invalid pair. try again"
        guessed_pair.each { |card| card.face_up = false}
        sleep(3)
        @board.render(@num_guesses)
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "Please provide an even number: "
    grid_width = gets.chomp.to_i
    if grid_width.odd?
        until grid_width.even?
            puts "Please provide an EVEN number: "
            grid_width = gets.chomp.to_i
        end
    end
    game = Game.new(grid_width)
    game.play
end