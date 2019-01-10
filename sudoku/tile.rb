class Tile
    attr_accessor :value, :guessed, :provided

    def initialize(value)
        @value = value
        @guessed = false
        value == 0 ? @provided = false : @provided = true
    end

    def to_s
        if self.value == 0
            "|   "
        elsif self.guessed
            "| #{self.value} "
        else #hidden
            "|[#{self.value}]" # The [] mean that you cannot change
        end
    end


end