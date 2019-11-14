class RemoveProductFromBrand < ActiveRecord::Migration[5.2]
  def change
    remove_reference :brands, :product
  end
end
