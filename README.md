# グルメモ
![トップ画面](https://github.com/purupuruputtyan/gourmemo/assets/125232334/e118b45e-6208-43cc-9d4f-536cc78de3d0)

## URL
[https://gourmemo.blog](https://gourmemo.blog/)</br>
【ゲストログイン】のボタンをクリックしていただければ、ユーザー登録不要でログインができます。</br>
管理者へは非ログイン時のフッターに存在する[管理者はこちら](https://gourmemo.blog/admin/sign_in)をクリックし、</br>
下記情報をご入力いただけますとログインができます。

* メールアドレス：admin@admin
* パスワード：adminadmin

## サイト概要
グルメモユーザーさんが召し上がったお食事の内容をSNSのように発信し他のユーザーさんと共有することができ、
発信の際にレビューもすることができる複合サービスです。

## サイトテーマ
召し上がったお食事の情報をレビューと共に発信できるSNSサイトです。</br>
「また食べたい度」として投稿時に星によるレビューができるため、
文字通りまた食べに行きたいという気持ちが可視化され他のユーザーさんにも伝わりやすいです。</br>
お食事が「おいしかった」、「見た目が綺麗だった」などの感想だけを発信するのではなく、
金額や量が物足りなかったなどの量感なども記録することができるため、
気になるお店や食べ物がある場合、このサイトで投稿をお探しいただければお店探しのわかりやすい指標として貢献できます。
また、SNSのように他のユーザーさんと繋がることができるため、ユーザーさんのお気に入りのお店を見つける手助けになります。

## テーマを選んだ理由
食べることが好きな方々が食の好みの合う方と繋がり、お気に入りのお店や食べ物について情報発信することで、
ユーザーさんの食事による幸福度を上げ、コロナの影響でダメージを受けてしまった飲食店の復興のお役に立てればと思いこのテーマにいたしました。

##  似たようなサービスとの違い
SNSとレビューサイトが掛け合わさることにより、SNSのようにレビューが書き手の裁量に左右されることがなく、
レビューサイトより広い人脈網を構築することができるため発信された情報による影響力が図れます。

## ターゲットユーザ
* 老若男女食べることが好きな方
* カフェ巡りやパン屋さん巡りなどが好きで情報を発信したい方
* 食の好みが合う方と繋がりたい方

## 主な利用シーン
* 召し上がったお食事の情報を発信したい時
* おすすめのお店を紹介したい時
* 食の好みが合う方とおすすめのお店について話し合いたい時

## 実装機能一覧
* ゲストログイン機能
* ユーザー公開、非公開、退会機能
* 管理者監視機能（不適切な投稿、コメントの削除、ユーザーの退会処理）
* 投稿機能（CURD）
* Raty☆評価機能（投稿機能で投稿する際に☆評価をする）</br>
 <img width="300" alt="スクリーンショット 2023-06-18 15 55 24" src="https://github.com/purupuruputtyan/gourmemo/assets/125232334/2924a245-fd60-4b0c-96d4-8c49e3aa486a"></br>
* いいね機能（非同期化）
* フォロー機能（非同期化）
* コメント機能（非同期化）
* ソート機能（新しい順、古い順、いいね多い順、星多い順、コメント多い順）
* 画像プレビュー機能（JavaScript:新規投稿画面、投稿編集画面、プロフィール編集画面）
* 検索機能（ユーザー名、メニュー名あいまい検索）
* マップ表示（gem:Geocorder、API:Geocoding API、Maps JavaScript API）</br>
 <img width="300" alt="スクリーンショット 2023-06-18 15 56 18" src="https://github.com/purupuruputtyan/gourmemo/assets/125232334/98183145-0734-4b27-ab77-c2dfe5c4c30a"></br>
* レスポンシブデザイン</br>
 【上段：PC画面、下段：スマホ画面】
 <img width="350" alt="スクリーンショット 2023-06-18 16 00 49" src="https://github.com/purupuruputtyan/gourmemo/assets/125232334/e84f9779-0c52-404d-8d84-bdc6b7c40e58">
 <img width="350" alt="スクリーンショット 2023-06-18 16 56 04" src="https://github.com/purupuruputtyan/gourmemo/assets/125232334/c9dd5f09-341a-45cc-b1dd-d5e72ba6b7ce"></br>
 <img width="150" alt="スクリーンショット 2023-06-18 13 01 12" src="https://github.com/purupuruputtyan/gourmemo/assets/125232334/01a176ce-3338-4fff-8f88-6cac9a3119db">
 <img width="150" alt="スクリーンショット 2023-06-18 16 59 08" src="https://github.com/purupuruputtyan/gourmemo/assets/125232334/db0458dc-55be-41ee-aaca-5423666c4cae"></br>

## 設計書
* ER-図</br>
![ER-図](https://github.com/purupuruputtyan/gourmemo/assets/125232334/43b6eb7d-361a-44f2-9c02-0387a3fab762)
* [テーブル定義書](https://docs.google.com/spreadsheets/d/14xiu30fAtfGhKccVJcjfzS4OSJhOn4Bb7xRlfqMfLr0/edit#gid=1373217982)
* [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1JDjvKIgUSdZqSr7BulIy5VqYVIshHa2IlF3i3uH2l5c/edit#gid=549108681)
* インフラ構成図</br>
![AWS構成図 drawio](https://github.com/purupuruputtyan/gourmemo/assets/125232334/8c6f24c7-4fa7-4558-bd25-5de78327e719)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
* 背景画像
  - [サイト:イラストAC](https://www.ac-illust.com/main/detail.php?id=2616215&word=%E3%82%AB%E3%83%88%E3%83%A9%E3%83%AA%E3%83%BC%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E2%80%BBpng%E8%83%8C%E6%99%AF%E9%80%8F%E6%98%8E)
* テストデータ
  - ユーザープロフィール：いらすとや
    - 武田信玄
    - 上杉謙信
    - 織田信長
    - 明智光秀
    - 豊臣秀吉
    - 石田三成
    - 伊達政宗
  - 投稿写真：photo AC
    - 豆大福
    - チャーハン
    - ショートケーキ
    - メロンパン
    - カルボナーラ
    - お好み焼き
    - 天ぷらそば
 - その写真：自前