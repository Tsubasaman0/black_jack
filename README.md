# ブラックジャックの構成
## 必要なパーツ
### カードクラス
- A~Kまでの数と、♤、♧、♦︎、❤︎の４種類合計５２枚のカード（ジョーカーは抜く）
- 手札に対象のカードが入った場合５２枚の中から、その対象のカードを消す。（同じカードを引かないようにする為）
- カードの見た目　例: [ ♦︎ J ] [ ♤ 3 ]
- j, Q, Kは10の値を入れる
- Aはhandの合計値が11以下の場合は10、11以以上の場合は1
***
### プレイヤークラス
- プレイヤーが持つデータ（initialize）
    - hand 自分の手札
- メソッド
    - draw カードを一枚引く
    - total 合計値を返す
***
### モジュール
- show お互いの手札を確認
- judge 勝敗の判定をする
***
## ゲームの流れ
1. プレイヤーのターン
    - お互いの手札の確認
    - ヒット or スタンドの選択
        - ブラックジャックの場合は強制終了
    - スタンドを選択、もしくはバーストするまでヒットを繰り返す
2. ゲームマスターのターン
    - プレイヤーの値を超えるか、バーストになるまでヒットし続ける。
        - ブラックジャックの場合は強制終了してjudge
***

