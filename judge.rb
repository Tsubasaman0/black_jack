module Judge

    def bet_judge(bet, judge)
        case judge
        when :win
            bet * 2
        when :lose
            return 0
        when :blackjack
            bet * 3
        when :draw
            bet
        end
    end

    def blackjack?
        if self.hands[1].number == "A" || self.hands[0].number == "A" 
            if  self.hands[0].number == "J" || self.hands[0].number == "Q"|| self.hands[0].number == "K" || \
                self.hands[1].number == "J" || self.hands[1].number == "Q"|| self.hands[1].number == "K"
                self.total_score = "ブラックジャック"
                true
            else
                false
            end
        else
            false
        end
    end

    def burst?
        self.total_score > 21 ? true : false
    end

    def in_a?
        self.hands.map do |card|
            if card.number == 'A'
                return true
            end
        end
        false
    end

end