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
|phone_number|integer|unique: true, null: false|
|user_image|string||
|profile|text||

<!-- アカウント作成に必要だった要素はnull: falseをつけた -->

### Association
- has_many :products
- has_many :buyed_products, foreign_key: "buyer_id", class_name: "Product"
- has_many :selling_products, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Product"
- has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Product"
- has_many :comments
- has_many :trade_messages

<!-- アソシエーションを組んだ。他の方法もあるようだがこれが最もシンプルな構造 -->


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|product_image|null: false|  
<!-- 複数画像アップロードならActive Storageとか使うべき？ -->
|description|text|null: false|
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


## trade_messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|refeerences|foreign_key: true|
|user_id|references|foreign_key: true|
|message|text|null: false|

### Association
- belongs_to :user
- belongs_to :product
