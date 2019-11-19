class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :products
  has_many :bought_products, foreign_key: "buyer_id", class_name: "Product"
  has_many :selling_products, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Product"
  has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Product"
  has_many :sns_credentials, dependent: :destroy
  has_many :creditcards , dependent: :destroy
  has_one :address
    accepts_nested_attributes_for :address

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d{11}\z/
  
  # step2入力項目
  validates :nickname,          presence: true, length: { maximum: 20}
  validates :email,             presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX } 
  validates :firstname,         presence: true, length: { maximum: 35}
  validates :lastname,          presence: true, length: { maximum: 35}
  validates :firstname_kana,    presence: true, length: { maximum: 35}
  validates :lastname_kana,     presence: true, length: { maximum: 35}
  validates :birth_year,        presence: true
  validates :birth_month,       presence: true
  validates :birth_day,         presence: true
  
  # step3入力項目
  validates :phone_number,      presence: true, on: :registrations, uniqueness: true, format: { with: VALID_PHONE_REGEX } 

  def already_liked?(product)
    self.likes.exists?(product_id: product.id)
  end
end
