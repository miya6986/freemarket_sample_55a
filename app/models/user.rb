class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable.
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :products
  has_many :bought_products, foreign_key: "buyer_id", class_name: "Product"
  has_many :selling_products, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Product"
  has_many :sold_products, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Product"
  has_many :sns_credentials, dependent: :destroy
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
  validates :phone_number,      presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX } 

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = User.where(id: snscredential.user_id).first
    else
      user = User.where(email: auth.info.email).first
      if user.present?
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      else
        user = User.create(
          nickname: auth.info.name,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
          )
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      end
    end
    return user
  end

end