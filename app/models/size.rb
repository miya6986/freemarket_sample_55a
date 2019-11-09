class Size < ApplicationRecord
  has_ancestry
  has_many :categories, through: :category_sizes
end
