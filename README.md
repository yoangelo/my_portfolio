# Child Rest

## アプリURL

ワンタッチボタンでテストユーザーでログイン可能です。
ご確認される際はぜひご利用ください。
https://childrest.com

## サービスの概要
転職活動用のポートフォリオとして作成しました。
子連れファミリーに向けたレストランの口コミ共有サービスです。
レストランに紐づいた口コミを投稿することができます。
開発環境にDocker、本番環境のインフラ構築にAWSを使用しました。
また、```git push```時にCircleCIの自動ビルド&テストを採用しています。

## なぜこのサービスを作ったか
お子様がいるご家庭の外食はかなりハードで、お店選びは慎重に行わなければいけません。（子供用食器があるか、チャイルドチェアがあるか、お子様ランチがあるか、等）
そんなとき、小さい子どもを持つ親目線で書いたレストランの口コミ共有サイトがあれば、このような悩みに寄り添えるのではないかと思い、我々夫婦と同じ悩みを持つ人たちに向けて作成しました。

## 使用技術

### 環境
Dockerによる以下の環境構築による開発
- Ruby 2.5.3
- Rails 5.2.2
- MySQL 5.7

### インフラ
- AWS (EC2, RDS for MySQL, S3, VPC, Route53, ALB, ACM)
- Nginx
- Unicorn

### ネットワーク構成図
![ネットワーク構成図](https://user-images.githubusercontent.com/56621211/85896344-43e2c780-b833-11ea-8c46-ce28bc1158e2.png)

### ER図
![ER図](https://user-images.githubusercontent.com/56621211/85896325-3c232300-b833-11ea-9ad5-e2e9f96a3288.png)

### 機能一覧
- ユーザーログイン・登録機能（Devise）
- Twitterログイン機能（Devise、OmniAuth）
- ぐるなびAPIを用いたレストラン検索(Ajaxによる非同期通信)および登録機能
![レストラン検索機能(short Ver )](https://user-images.githubusercontent.com/56621211/85923406-aab0c100-b8c5-11ea-9140-1e4ff18f03d5.gif)
- レストランに対する口コミ投稿のCRUD機能(ポリモーフィック関連)
- 口コミに対するコメント登録・削除機能(Ajaxによる非同期通信)
- 口コミに対するお気に入り登録・解除機能(Ajaxによる非同期通信)
- 口コミに対するタグ付け機能(タグに関連する口コミ一覧表示)
- 口コミに対するカテゴリー機能(カテゴリーに関連する口コミ一覧表示)
- コメント、お気に入りに対する通知機能
- 登録済レストランおよび口コミの検索機能
- 画像投稿機能
- ユーザーのプロフィール登録機能（ユーザーが投稿した口コミ一覧表示)

### その他の技術
- RSpec
- Rubocop
- SASS, JQuery
- CircleCi CI/CD

## 開発において意識したこと

- UIデザイン

ユーザーがアプリを使用する際、使用方法がわかりやすいシンプルなUIデザインになるように心がけました。
また、主に子どもを持つファミリー層にターゲットを向けているため、全体的に柔らかい印象を持つようなビューになるようにしました。

- GitHubによるisuue管理

常に以下のルーティンを繰り返し、チーム開発を見据えて開発を行ってきました。
1. タスクを細分化
2. issue登録
3. issueに関連したブランチ作成および開発
4. プルリクを提出
5. 動作確認後、マージ承認
6. ローカルのmasterブランチにPull
