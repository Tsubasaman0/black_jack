require './player'
require './money'

class Play
    @@money = Money.new
    @@t = 'test'
    def initialize
        @player = Player.new
        @dealer = Player.new(name: 'ディーラー')
        play
    end

    def message(title, choice1="ヒット", choice2="スタンド") # win or lose or draw or error
        case title
        when :win
            puts 'あなたの勝ちです'
        when :lose
            puts 'あなたの負けです'
        when :draw
            puts '引き分けです'
        when :error
            puts '無効な文字です。もう一度入力してください'
        when :choice
            puts "選択してください\s\sPush「 1 」→ #{choice1} 、Push「 2 」→ #{choice2}" # hとsを１、２にしたい。ヒット、スタンド部分に引数を当てられるようにしたい。
        end
    end

    def dealer_turn
        # スタンド時の処理（ディーラーのターン）
        puts 'ディーラーのターンです'
        wait
        # プレイヤーがブラックジャックだった場合のディーラーの処理 
        if @player.blackjack?
            @dealer.draw
            @dealer.show
            if !@dealer.blackjack?
                message :win
                return
            else
                message :draw
                return
            end
        end
        # プレイヤーに勝つまでディーラーはヒットし続ける処理
        while @player.total_score > @dealer.total_score
            @dealer.draw
            @dealer.show
            wait
            if @dealer.burst?
                puts 'バースト！'
                message :win
                break
            elsif @dealer.total_score == 21 && @player.total_score == 21
                message :draw
                break
            end
        end

        if @dealer.burst? # バーストしていた場合処理処理終了
            return
        elsif @dealer.total_score == 21 && @player.total_score == 21 # お互い最大値に達していないか確認
            message :draw
            return
        else
            message :lose
            return
        end
    end

    def play
        while true # 再プレイのためのループ処理
            # 手札リセット
            @player.reset
            @dealer.reset
            # 初ターンの処理
            puts "ようこそ、ブラックジャックへ"
            puts "カードを配ります"
            @player.draw
            @player.draw
            @dealer.draw  
            @dealer.show

            # プレイヤーがブラックジャックじゃないか確認の処理
            if @player.blackjack?
                    puts "ブラックジャック！"
                    @player.show
            else
                @player.show
                message :choice
            end

            # ヒット、スタンドの処理（プレイヤーのターン）
            while true
                # ブラックジャックの場合は強制的にスタンドさせる処理
                if @player.blackjack?
                    command = 2
                else
                    command = gets.to_i # ヒットかスタンドか選択
                end
                # ヒットの場合の処理
                if command == 1
                    while true
                        @player.draw
                        if @player.burst? # バーストしていないか確認
                            @player.show
                            puts "バースト！！"
                            message :lose
                            break
                        end
                        # ドロー後のトータルスコアの確認
                        @player.show
                        # 最大値（２１）の場合は強制的にスタンドの処理
                        if @player.total_score == 21
                            puts 'トータルスコアが最大値に達しました'
                            command = 2
                            break
                        end
                        # 最大値ではない場合は、再度ヒットするか処理
                        puts "もう一度引きますか？"
                        message :choice
                        while true
                            command = gets.to_i # 再度、ヒットかスタンドの選択
                            if command == 1
                                break
                            elsif command == 2
                                break
                            else
                                message :error
                                redo
                            end
                        end
                        # ヒットかスタンドの処理
                        if command == 1 
                            redo
                        elsif command == 2
                            break
                        end
                    end
                    # バースト時の強制終了処理
                    if @player.burst?
                        break
                    end
                elsif command == 2
                    dealer_turn
                    command = nil
                    break
                else
                    # h,s以外が入力されたときの処理
                    message :error
                    redo
                end
                if command == 2
                    dealer_turn
                    break
                end
            end
            # 再プレイの処理
            puts "もう一回遊びますか？"
            message :choice, "遊ぶ", "遊ばない"
            while true
                command = gets.to_i # 再プレイするか選択
                if command == 1
                    command = nil
                    break
                elsif command == 2
                    break
                else
                    message :error
                    redo
                end
            end
            # 再プレイの処理
            command == nil ? redo : break
        end
    end

    def wait(words='Enterキーを押してください')
        puts words
        c = gets
    end
end

Play.new