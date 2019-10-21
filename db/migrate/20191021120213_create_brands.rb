class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name,           null: false, index: true
      t.references :product,    foerign_key: true

      t.timestamps
    end
  end
end
