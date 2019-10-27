class Product < ApplicationRecord
  # belongs_to :seller, class_name: "User"
  # belongs_to :buyer, class_name: "User"
  # belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  # belongs_to :brand
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end





