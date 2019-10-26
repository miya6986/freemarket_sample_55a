class Address < ApplicationRecord
  belongs_to :user
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates     :firstname,          presence: true, length: { maximum: 35 }
  validates     :lastname,           presence: true, length: { maximum: 35 }
  validates     :firstname_kana,     presence: true, length: { maximum: 35 }
  validates     :lastname_kana,      presence: true, length: { maximum: 35 }
  validates     :postalcode,                 presence: true
  validates     :prefecture_id,              presence: true
  validates     :city_name,                  presence: true, length: { maximum: 50 }
  validates     :address_number,             presence: true, length: { maximum: 100 }
  validates     :building_name,              length: { maximum: 100 }
  validates     :phone_number,       length: { maximum: 100 }
end