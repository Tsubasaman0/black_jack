require './deck'
require './judge'


class Player
    include Judge
    attr_accessor :hands, :total_score, :name
    @@deck = Deck.new
    def initialize(name: "プレイヤー")
        @hands = []
        @total_score = 0
        @name = name
    end

    def draw
        self.hands << @@deck.draw
        self.total_score = self.total_score_calc
        @@deck.draw_count
    end

    
    def show
        puts "#{self.name}の手札です"
        self.hands.each do |hand|
            puts "[ #{hand.mark} #{hand.number} ]"
        end
        puts "[ トータルスコア #{@total_score} ]"
    end

    def a_count
        a = 0
        self.hands.each do |card|
            if card.number == 'A'
                a += 1
            end
        end
        a
    end
    
    def reset
        self.hands = []
        self.total_score = 0
        @@deck.reset
    end

    def total_score_calc
        @total_score = 0 # 複数回計算した場合に、加算しないように、毎回トータルスコアをリセットする
        self.hands.each do |hand|   # @numberに「A」があり、トータルスコアが２２以上ある場合、「A」の数だけ、トータルスコアから-9する。「A」の数をカウントするメソッドを作る。
            @total_score += hand.convert
        end
        if self.burst? && self.in_a?
            @total_score -= (self.a_count * 9)                # 「A」の数だけ、トータルスコアから-9する。「A」の数をカウントするメソッドを作る。
        end
        @total_score
    end
    # テスト用メソッド

    def test
        puts "テストーーーーーー"
    end



    def reset_score
        self.total_score = 0
    end

    def in_blackjack
        self.hands << Card.new("♦︎", "J")
        self.hands << Card.new("♦︎", "A")
    end
end

# player = Player.new
# enemy  = Player.new
# player.draw
# player.draw
# enemy.draw
# enemy.draw
# player.hands
# player.total_score_calc
# enemy.total_score_calc
# p player.blackjack?
# p enemy.blackjack?
