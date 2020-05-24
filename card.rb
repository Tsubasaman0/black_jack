class Card 
    attr_reader :mark, :number
    def initialize(mark, number)
        @mark   = mark.freeze
        @number = number.freeze
    end

    def convert
        if @number == 'J' || @number == 'Q' || @number == 'K' || @number == 'A'
            10
        else
            @number.to_i
        end
    end
end