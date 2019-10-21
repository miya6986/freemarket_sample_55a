class Product < ApplicationRecord
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  belongs_to :user
  has_many :images
end
