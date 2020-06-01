class Money
    attr_accessor :stock
    def initialize
        @stock = 20000
    end

    def show
        puts "現在の手持ちは #{self.stock} 円です"
    end
end