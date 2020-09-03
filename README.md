# Child Rest

![image](https://user-images.githubusercontent.com/56621211/85946004-73511b80-b97c-11ea-8a2c-ab2d35ffd6ba.png)

## 作成者の連絡先
武野 聖也

✉️ : kenose0328@gmail.com

## 概要

Ruby on Rails を独学し、そのポートフォリオとして作成しました。
子連れファミリーに向けたレストランの口コミ共有サービスとなっております。
レストランデータに紐づいた口コミを投稿することができます。

## URL

[https://childrest.com](https://childrest.com/)

ワンタッチでテストユーザーでログイン可能です。 ご確認される際はぜひご利用ください。

## なぜこのサービスを作ったか

お子様がいるご家庭の外食はかなりハードで、お店選びは慎重に行わなければいけません。（子供用食器があるか、チャイルドチェアがあるか、お子様ランチがあるか、等）
そんなとき、小さい子どもを持つ親目線で書いたレストランの口コミ共有サイトがあれば、このような悩みに寄り添えるのではないかと思い、同じ悩みを持つ人たちに向けて作成しました。

## 使用技術

- Ruby 2.5.3
- Ruby on Rails 5.2.2
- JavaScript (jQuery)
- Bootstrap
- AWS (EC2, RDS for MySQL, S3, VPC, Route53, ALB, ACM)
- Docker/docker-compose
- CircleCI (CI/CD)
- Nginx, Unicorn
- RSpec
- Git, GitHub
- Rubocop

## ネットワーク構成図

![ネットワーク構成図](https://user-images.githubusercontent.com/56621211/85896344-43e2c780-b833-11ea-8c46-ce28bc1158e2.png)

## ER図

![ER図](https://user-images.githubusercontent.com/56621211/85896325-3c232300-b833-11ea-9ad5-e2e9f96a3288.png)

## 機能一覧

- ユーザーログイン・登録機能（Devise gem）

- TwitterによるOAuthログイン機能（Devise gem）

- ぐるなびAPIを用いたレストラン検索(Ajaxによる非同期通信)および登録機能

  ![レストラン検索機能(short Ver )](https://user-images.githubusercontent.com/56621211/85923406-aab0c100-b8c5-11ea-9140-1e4ff18f03d5.gif)

- レストランに対する口コミ投稿のCRUD機能

- 登録レストランの地図表示機能 (GoogleMap API)

- 口コミに対するコメント登録・削除機能(Ajaxによる非同期通信)

- 口コミに対するいいね登録・解除機能(Ajaxによる非同期通信)

- 口コミに対するタグ付け機能(タグに関連する口コミ一覧表示)

- 口コミに対するカテゴリー機能(カテゴリーに関連する口コミ一覧表示)

- コメント、いいねに対する通知機能

- 登録済レストランおよび口コミの検索機能

- 画像投稿機能

- ユーザーのプロフィール登録・編集機能（ユーザーが投稿した口コミ一覧表示)

## 開発において意識した事

- 使用方法がわかりやすいシンプルなUIデザインになるように心がけました。
- 全体的に柔らかい印象を持つようなビューになるようにしました。
- ポートフォリオの内容は誰かの悩みを解決できるサービスにしようと心がけました。(子どもも利用しやすいレストランを探しているファミリーに向けた内容です。)
- GitHubによるisuue管理を繰り返すことでチーム開発を見据えて開発を行ってきました。
