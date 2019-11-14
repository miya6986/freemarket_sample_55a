class Category < ApplicationRecord
  has_ancestry
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  has_many :category_sizes
  has_many :sizes, through: :category_sizes
end
