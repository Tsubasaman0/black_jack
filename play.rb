require './player'

class Play
    attr_accessor :player, :dealer

    def initialize
        @player = Player.new
        @dealer = Player.new(name: "ディーラー")
        test
    end

    def test
        @player.draw
    end
end

Play.new