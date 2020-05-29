
class Deck
    attr_accessor :cards
    @@draw_count = 0

    def initialize
        @cards = []
        create
        @cards = @cards.shuffle
    end

    def create
        nums = ['A', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K']
        mark = ["❤ ハート\s\s\s\s", "♦︎ ダイヤ\s\s\s\s", "♤ スペード\s\s", "♧ クローバー"]
        mark.each do |m|
            nums.each do |n|
                @cards << Card.new(m, n)
            end
        end
    end

    def draw
        cards[@@draw_count]
    end

    def draw_count
        @@draw_count += 1
    end

    # テスト用のカード参照メソッド
    def show
        52.times do |n|
            puts "[ #{cards[n].mark} #{cards[n].number} ]"
        end
    end

    def reset
        @cards = @cards.shuffle
        @@draw_count = 0
    end
end

#deck = Deck.new
#deck.show

# drawメソッドを作るためのテスト
# デッキの一番上のカード、つまりcards[0]を引く
# デッキの一番上の要素をshiftで削除
# これを繰り返す
# test = [1,2,3,4,5,]
# test.shift
# p test[0]