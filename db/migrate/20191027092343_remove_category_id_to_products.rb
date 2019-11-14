class RemoveCategoryIdToProducts < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :products, :categories
    remove_reference :products, :category, index: true

  end
end
