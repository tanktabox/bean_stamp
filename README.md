# [Bean Stamp](https://www.bean-stamp.net/)

!["トップ画面"](https://user-images.githubusercontent.com/67009309/226169657-f462e72e-0338-4c39-a0d2-e64c760d4525.png)

## 概要

Bean Stamp はコーヒー豆とコーヒー愛好家を繋ぐマッチングサービスです。
コーヒーロースターは焙煎する予定のコーヒー豆を Bean Stamp に登録し、それをコーヒー愛好家に向け提案という形で購入者を募集（オファー機能）することができます。
その提案（オファー）に対してユーザーは購入する意思表示（ウォント）をすることで、焙煎豆の先行予約ができるサービスです。
コーヒーロースターにとっては焙煎する前に購入者を募集できるため、焙煎豆の廃棄処分をするリスクを減らすことができます。
ユーザーにとっては焙煎したてで鮮度の良い状態の焙煎豆を購入することができます。

![bean_stamp概要-全体像](https://user-images.githubusercontent.com/67009309/229818953-9d138092-fda3-4a08-88c1-a643c64bc0bc.jpg)

### URL: <https://www.bean-stamp.net>

ユーザー：ホーム画面
!["アプリケーションホーム"](https://user-images.githubusercontent.com/67009309/229341523-4d73464b-3487-4165-afa3-74bf9694b2b0.png)

ロースター：コーヒー豆登録画面
!["コーヒー豆登録画面"](https://user-images.githubusercontent.com/67009309/226169647-893eb6a9-533c-4a22-9dbf-d0dfc2b77e47.png)

ユーザー：コーヒー豆受け取り完了 → 評価
![コーヒー評価デモ](https://user-images.githubusercontent.com/67009309/226931274-fc79374f-73b5-4096-936d-0bc05858cff9.gif)

## 特に見ていただきたいポイント

- 食品開発の中で習得した知識や経験を応用し、既存の課題にフォーカスしていること
- フロントエンドとバックエンドを分離し、SPA(Single Page Application)の構成をとっていること
- フロントエンドで React および TypeScript を使用して開発を行なっていること
- バッジや通知機能を実装することで、次に何をするのか分かりやすい UI にしていること
- これまでの経験で得た風味表現や評価方法を元とするアイディアをロジックとして実現し、レコメンド機能を実装していること
- フロントエンドは S3 にホスト、バックエンドは ECS(Fargate)で稼働させ、サーバーレスで本番環境を構築していること
- フロントエンドや画像などのアセットは CloudFront を使用することで高速かつセキュアに配信を行なっていること
- Docker による開発環境およびバックエンドの本番環境の構築を行なっていること
- CircleCI を利用し、フロントエンドおよびバックエンドの自動デプロイを行なっていること

## 背景

私は加工食品メーカーで食品開発を仕事としています。
また、コーヒー好きが高じてコーヒー豆の品質を評価することができる国際資格を取りました。
普段から様々な人にコーヒーを淹れてあげたり紹介したりしている中で、コーヒー豆を買ってきても自分で美味しく淹れることができないという意見を多く耳にしました。
また、コーヒーロースターからは焙煎豆を大量に廃棄処分をしている話も伺いました。
あまりイメージはありませんがコーヒーはもともと木になるフルーツで、生豆から焙煎豆に加工した段階で急速に劣化が進みます。
ロースターにより考え方は様々ですが、焙煎豆の賞味期限（美味しく飲めると保証する期間）はおよそ 1 ヶ月です。
そこで、① 買ってきたコーヒーが美味しくないという消費者側の問題と、② 焙煎した豆を捨てないといけないという販売者側の問題の解決ができないかと考えまいた。

まず、ロースターは消費者に美味しいコーヒーを届けたいという気持ちと、在庫廃棄を減らし少しでも利益を上げたいという気持ちで葛藤しています。
美味しいコーヒーを届けるためには多少古くなった焙煎豆は廃棄しなければなりません（問題 ②）。
一方、利益を確保するために焙煎豆の在庫回転率を下げると消費者に古い豆が渡る可能性があります（問題 ① につながる）。
そこで焙煎する前の生豆の段階で購入希望者を募ることで、鮮度のよい焙煎豆を確実且つ効率よく消費者に届けることができるサービスを作りたいという考えに至りました。

## 使用言語、環境、テクノロジー

### フロントエンド

- HTML / CSS
- Tailwind CSS (3.1.6)
- React.js (18.2.0)
- TypeScript (4.7.4)
- Node.js (16.11.1)
- Yarn (パッケージ管理)
- Prettier (コード解析ツール)

### バックエンド

- Ruby (3.0.4)
- Ruby on Rails (6.1.4)
- MySQL (8.0.26)
- RuboCop (テスト)
- Rspec (コード解析ツール)

### インフラ

- AWS [ ECS(Fargate), ECR, VPC, RDS, ALB, S3, ACM, Route53, Cloud Front, Cloud Watch ]
- Docker
- Nginx (Web サーバー)
- Puma (アプリケーションサーバー)

### CI/CD

- CircleCI (自動テスト、自動ビルド、自動デプロイ)

### バージョン管理

- Git / GitHub

### 開発環境

- VSCode
- Docker / docker-compose

## ER 図

![Beans Stamp ER図(SPA)](https://user-images.githubusercontent.com/67009309/226169804-cdde1779-de3c-4bc3-905b-ae6fc96a6c10.png)

## インフラ構成図

![Bean Stamp インフラ構成図(SPA)](https://user-images.githubusercontent.com/67009309/226169792-f89fe77c-3019-462d-912e-87b50e5a967b.png)

## 機能一覧

### ユーザー

- トークン認証機能(devise-token-auth)：新規登録、ログイン／ログアウト
- ゲストログイン機能
- プロフィール編集、画像登録
- ロースターのフォロー機能／フォローしているロースターの一覧表示機能
- オファーへ購入希望表明機能 (ウォント機能)／ウォントしているオファーの一覧表示 (オファーのステータスによる絞り込み可能)
- オファーのお気に入り登録／お気に入りしたオファーの一覧表示
- コーヒー豆の評価機能
- ウォントしているオファー数をバッジで通知

### ロースター

- ロースター登録機能
- 店舗情報編集、プロフィール画像登録
- ロースターをフォローしてくれているユーザーの一覧表示
- ロースターが登録したコーヒー豆の一覧表示
- ロースターのオファーの一覧表示 (オファーのステータスによる絞り込み可能)
- ウォントしているユーザーの一覧表示
- ロースターの検索機能 (ransack)

### コーヒー豆

- コーヒー豆の登録、詳細、編集、削除
- 画像登録、カルーセル表示 (swiper)
- 風味の点数登録とレーダーチャートでの表示 (chart.js)

### オファー

- コーヒー豆からオファーを作成、詳細、編集、削除
- オファーのステータス表示(オファー中、ロースト期間、準備中、受け取り期間、受け取り終了)
- オファーの検索機能
- オファーの通知機能

### リコメンド

- ユーザーに対して好みの風味を持つコーヒー豆のオファーをリコメンドする機能

#### リコメンドまでの流れ

1. 受け取ったコーヒー豆に対してユーザーが評価を行う。(bad, so so, good, excellent の 4 段階)
2. コーヒー豆はそれぞれ風味をタグとして保有しているため、コーヒー豆に対する評価はタグの風味に点数がついたとする。
3. 風味はそれぞれ上位の風味グループに属しており、その風味グループ毎に集計を行う。
   例えば、`Lemon`という風味はより上位の`Citrus`という風味グループに属していると考える。
   <https://github.com/tanktabox/bean_stamp/blob/main/api/app/models/user.rb#L48-L63>
4. 評価が高い上位 2 種類の風味グループを持つコーヒー豆のオファーをおすすめのオファーとする。
5. フロントエンド側では`Offer#recommend` API を叩くことで、バックエンド側で`3`,`4`の処理を行い返却されたおすすめのオファー一覧を、Global State として保持する。
6. Global State として保持しているおすすめのオファー一覧からランダムにサンプリングして、画面にレンダリングを行う。

![bean_stamp概要-レコメンド機能の概要](https://user-images.githubusercontent.com/67009309/229818946-88f649b3-9952-416d-b8e0-79dac41e41ca.jpg)

### その他

- 完全 SPA
- 入力フォームのバリデーション (react-hook-form)
- セレクトボックスの検索機能 (react-select)
- レスポンシブ対応
- ページネーション (react-paginate)
- 管理者機能 (rails_admin)
