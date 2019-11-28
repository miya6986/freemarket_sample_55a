class Product < ApplicationRecord
  
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  belongs_to :brand, optional:true
  accepts_nested_attributes_for :brand
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

  validate :require_image
    def require_image
      image_validation = images
      if image_validation.empty?
        errors.add(:images, "画像がありません")
      end
    end
  
    #チェックボックス用enum
  enum search_condition: {new_item: "新品、未使用", new_like: "未使用に近い", no_dirt: "目立った傷や汚れなし", less_dirt: "やや傷や汚れあり", dirt: "傷や汚れあり", bad: "全体的に状態が悪い"}
  enum search_postage: {seller_cost: "着払い(購入者負担)", buyer_cost: "送料込み(出品者負担)"}
  enum statuse: {selling: "販売中", sold_out: "売り切れ"}
  
  # 検索用
  def self.condition_check_list
    { "0": 'すべて', "1": '新品、未使用', "2": '未使用に近い', "3": '目立った傷や汚れなし', "4": 'やや傷や汚れあり', "5": '傷や汚れあり', "6": '全体的に状態が悪い' }
  end

  def self.postage_check_list
    { "0": 'すべて', "1": '着払い(購入者負担)', "2": '送料込み(出品者負担)' }
  end

  def self.status_check_list
    { "0": 'すべて', "1": '販売中', "2,3": '売り切れ' }
  end

end





