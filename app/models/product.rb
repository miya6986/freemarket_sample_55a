class Product < ApplicationRecord
  # belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  #belongs_to :buyer, class_name: "User"
  #belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  # belongs_to :brand
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  
  validates :name, presence: true
  validates :description, presence: true
  validates :condition, presence: true
  validates :postage, presence: true
  validates :shipping_method, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_days, presence: true
  validates :price, 
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 300,
      less_than_or_equal_to: 9999999,
      allow_blank: true
    }
  validate :category_count
    def category_count
      category_validation = category_ids
      unless category_validation.length == 3
        errors.add(:category_ids,"選択してください")
      end
    end

end





