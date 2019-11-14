class Image < ApplicationRecord
  mount_uploader :name, ImageUploader
  validates :name, presence: true
  belongs_to :product
end
