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


# DB設計

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|unique: true, null: false|
|password|string|null: false|
|firstname|string|null: false|
|lastname|string|null: false|
|firstname_kana|string|null: false|
|lastname_kana|string|null: false|
|birthday|date|null: false|
|postalcode|integer||
|prefecture|string||
|city_name|string||
|address_number|string||
|building_name|string||
|gender|string||
|phone_number|string|unique: true, null: false|
|avatar|string||
|profile|text||

### Association
- has_many :products
- has_many :bought_products, foreign_key: "buyer_id", class_name: "Product"
- has_many :selling_products, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Product"
- has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Product"
- has_many :comments
- has_many :trade_messages
- has_many :evaluations
- has_many :evaluated_users, foreign_key: "evaluated_id", class_name: "Evaluation"
- has_many :likes
- has_many :liked_products, through: :likes, source: :product
- has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
- has_many :followings, through: :following_relationships
- has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
- has_many :followers, through: :follower_relationships
- has_many :creditcards
- has_many :sns_credentials, dependent: :destroy


## productsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|images|json|null: false|
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
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- has_many :product_categories
- belongs_to :category
- has_many :comments
- has_many :trade_messages
- has_one :evaluations
- has_many :likes
- has_many :liked_users, through: :likes, source: :user
- belongs_to :brand


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|ancestry|string|index: true|

### Association
- has_many :products
- has_ancestry


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|user_id|references|foreign_key: true|
|comment|text|null: false|

### Association
- belongs_to :user
- belongs_to :product


## trade_messagesテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|user_id|references|foreign_key: true|
|message|text|null: false|

### Association
- belongs_to :user
- belongs_to :product


## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|rate|integer|null: false|
|evaluate_id|integer|foreign_key: true|
|evaluated_id|intefer|foreign_key: true|
|product_id|integer|foreign_key: true|
|review|text||

### Association
- belongs_to :user
- belongs_to ;product
- belongs_to :evaluate_id, class_name: "User"
- belongs_to :evaluated_id, class_name: "User"


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|product_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|product_id|integer|foerign_key: true|
|name|string|null: false, index: true|

### Association
- has_many : products


## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|follower_id|references|foreign_key: true|
|following_id|references|foreign_key: true|

### Association
- belongs_to :follower, class_name: "User"
- belongs_to :following, class_name: "User"

<!-- フォロー機能、以前作ったアプリと同じアソシエーションにした。 -->


## creditcardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false|
|customer_id|string|null; false|
|card_id|string|null: false|

### Association
- belongs_to :user


## sns_credentialsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string||	
|provider|string||
|user_id|references|foreign_key: true|

### Association
- belongs_to :user, optional: true
