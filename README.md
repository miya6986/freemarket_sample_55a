# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false|
|password|string|null: false|
|firstname|string|null: false|
|lastname|string|null: false|
|firstname_kana|string|null: false|
|lastname_kana|string|null: false|
|birthday|integer|null: false|
|postalcode|integer||
|prefecture|string||
|city_name|string||
|address_number|string||
|building_name|string||
|gender|string||
|phone_number|integer|unique: true, null: false|
|user_image|string||
|profile|text||

<!-- アカウント作成に必要だった要素はnull: falseをつけた -->
<!-- クレジットカードの情報ってテーブル作るの...？ -->
<!-- userの住所情報はテーブル分ける...？ -->

### Association
- has_many :products
- has_many :buyed_products, foreign_key: "buyer_id", class_name: "Product"
- has_many :selling_products, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Product"
- has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Product"
- has_many :comments
- has_many :trade_messages
- has_many :evaluations
- has_many :likes
- has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
- has_many :followings, through: :following_relationships
- has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
- has_many :followers, through: :follower_relationships

<!-- productsテーブルとアソシエーションを組んだ。他の方法もあるようだがこれが最もシンプルな構造 -->
<!-- フォロー機能であるrelationshipsテーブルとのリレーションが複雑 -->


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|product_image|null: false|  
|description|text|null: false|
|size|string||
|condition|string|null: false|
|postage|string|null: false|
|shipping_method|string|null: false|
|source_area|string|null: false|
|shipping_days|string|null: false|
|price|integer|null: false|
|buyer_id|references|foreign_key: true|
|seller_id|references|foreign_key: true|

### Association
- belongs_to :saler, class_name: "User"
- belongs_to :buyer, class_name: "User"
- has_many :product_categories
- has_many :categories, through: :product-categories
- has_many :comments
- has_many :trade_messages
- has_many :evaluations
- has_many :likes
- belongs_to :bland

<!-- メルカリって洋服のサイズ検索ないの？ -->
<!-- 複数画像アップロードならActive Storageとか使うべき？carrierwave使うならform_forでmultiple: trueで行けるか... -->


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|category|string|null: false, index: true|

### Association
- has_many :product_categories
- has_many :products, through: :product_categories


## product_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|category_id|references|foreign_key: true|

### Association
- belongs_to :product
- belongs_to :category

<!-- カテゴリー検索があるのでカテゴリーで抽出できるように。ハッシュタグと同じような仕組み -->
<!-- 大小カテゴリーをどのように作るか謎 -->


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|refeerences|foreign_key: true|
|user_id|references|foreign_key: true|
|comment|text|null: false|

### Association
- belongs_to :user
- belongs_to :product

<!-- 商品にコメント残せますね。userへの評価コメントとは別のもの -->
<!-- pictweetでやった -->


## trade_messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|refeerences|foreign_key: true|
|user_id|references|foreign_key: true|
|message|text|null: false|

### Association
- belongs_to :user
- belongs_to :product

<!-- user同士の取引時メッセージ機能 -->
<!-- chat-spaceでやった -->


## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|rate|integer|null: false|
|buyer_id|integer|foreign_key: true|
|seller_id|intefer|foreign_key: true|
|product_id|integer|foerign_key: true|
|review|text||

### Association
- belongs_to :buyer_id, class_name: "Product"
- belongs_to :seller_id, class_name: "Product"
- belongs_to :product

<!-- 買い手、売り手、商品をそれぞれ外部キーに指定。アソシエーションでuserの評価を抽出可能にする -->
<!-- 買い手と売り手分けるべき？user_idででいいかも... -->


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product

<!-- いいね機能 -->


## blandsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|foerign_key: true|
|bland|string|null: false|

### Association
- has_many : products

<!-- ブランドから検索もあったので抽出できるように -->


## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|follower_id|references|foreign_key: true|
|following_id|references|foreign_key: true|

### Association
- belongs_to :follower, class_name: "User"
- belongs_to :following, class_name: "User"

<!-- フォロー機能、以前作ったアプリと同じアソシエーションにした。 -->