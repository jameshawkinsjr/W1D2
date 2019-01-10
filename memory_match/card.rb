class Card
    attr_reader :value
    attr_accessor :face_up, :matched

    def initialize(value)
        @face_up = false
        @matched = false
        @value = value
    end

    def flip
        @face_up ? @face_up = false : @face_up = true
    end

    def to_s
        if self.matched
            "|   "
        elsif self.face_up
            "| #{self.value} "
        else #hidden
            "| @ " # @ == hidden
        end
    end

    def ==(card2) ## card1 == card2
        card2.value == self.value 
    end
end
