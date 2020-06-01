require 'minitest/autorun'
require './card'
require './deck'
require './judge'
require './money'
require './player'
class BlackJackTest < Minitest::Test
    # テストカードのマークは「 ♦︎ 」で統一
    @@test_J      = Card.new('♦︎', 'J')
    @@test_Q      = Card.new('♦︎', 'Q')
    @@test_K      = Card.new('♦︎', 'K')
    @@test_A      = Card.new('♦︎', 'A')
    @@test_5      = Card.new('♦︎', 5)
    @@test_10     = Card.new('♦︎', 10)
    @@test_player = Player.new

    def test_blackjack?
        blackjack_player = Player.new
        blackjack_player.hands << @@test_A
        blackjack_player.hands << @@test_J
        assert blackjack_player.blackjack?

        blackjack_player.reset
        blackjack_player.hands << @@test_J
        blackjack_player.hands << @@test_A
        assert blackjack_player.blackjack?

        blackjack_player.reset
        blackjack_player.hands << @@test_Q
        blackjack_player.hands << @@test_A
        assert blackjack_player.blackjack?

        blackjack_player.reset
        blackjack_player.hands << @@test_A
        blackjack_player.hands << @@test_Q
        assert blackjack_player.blackjack?

        blackjack_player.reset
        blackjack_player.hands << @@test_A
        blackjack_player.hands << @@test_K
        assert blackjack_player.blackjack?

        blackjack_player.reset
        blackjack_player.hands << @@test_K
        blackjack_player.hands << @@test_A
        assert blackjack_player.blackjack?

        # false パターン
        # blackjack_player.reset
        # blackjack_player.hands << @@test_A
        # blackjack_player.hands << @@test_10
        # assert blackjack_player.blackjack?

        # blackjack_player.reset
        # blackjack_player.hands << @@test_5
        # blackjack_player.hands << @@test_5
        # assert blackjack_player.blackjack?

        # blackjack_player.reset
        # blackjack_player.hands << @@test_J
        # blackjack_player.hands << @@test_Q
        # assert blackjack_player.blackjack?
        

    end

    def test_burst?
        burst_player = Player.new
        burst_player.hands << @@test_J
        burst_player.hands << @@test_J
        burst_player.hands << @@test_5
        burst_player.total_score_calc
        burst_player.total_score
        assert burst_player.burst?
        # false
        # burst_player.reset
        # burst_player.hands << @@test_10
        # burst_player.total_score
        # assert burst_player.burst?
    end

    def test_total_score_calc
        total_score_calc_player = Player.new
        total_score_calc_player.hands << @@test_10
        total_score_calc_player.hands << @@test_5
        total_score_calc_player.total_score_calc
        assert_equal 15, total_score_calc_player.total_score
        total_score_calc_player.reset
        total_score_calc_player.hands << @@test_A
        total_score_calc_player.hands << @@test_10
        total_score_calc_player.hands << @@test_5
        total_score_calc_player.total_score_calc
        assert_equal 16, total_score_calc_player.total_score
        total_score_calc_player.reset
        total_score_calc_player.hands << @@test_A
        total_score_calc_player.hands << @@test_J
        assert_equal 20, total_score_calc_player.total_score_calc
        total_score_calc_player.hands << @@test_5
        assert_equal 16, total_score_calc_player.total_score_calc
        total_score_calc_player.hands << @@test_A
        assert_equal 17, total_score_calc_player.total_score_calc
        # false
        #assert_equal 10, total_score_calc_player.total_score
    end


    def test_convert
        assert_equal 10, @@test_J.convert
        assert_equal 10, @@test_Q.convert
        assert_equal 10, @@test_K.convert
        assert_equal 10, @@test_A.convert
        assert_equal 5, @@test_5.convert
    end

    def test_draw_count
        deck = Deck.new
        assert_equal 1, @@test_player.draw
        assert_equal 2, @@test_player.draw
        assert_equal 3, @@test_player.draw
    end


    def test_a_count
        a_player = Player.new
        a_player.hands << @@test_A
        a_player.hands << @@test_A
        a_player.hands << @@test_A
        assert_equal 3, a_player.a_count
    end

    def test_bet_calc
        #assert_equal 19000, @@test_player.bet_calc(1000)
        
    end

    def test_bet_judge
        p @@test_player.money.stock -= 250 # ベット
        assert_equal 20250, @@test_player.bet_judge(250,  :win)
        assert_equal 19750, @@test_player.bet_judge(250,  :lose)
        assert_equal 20500, @@test_player.bet_judge(250,  :blackjack)
        assert_equal 20000, @@test_player.bet_judge(250,  :draw)
    end

end
