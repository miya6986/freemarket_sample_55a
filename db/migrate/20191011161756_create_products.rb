class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :prefecture_id,  null: false
      t.string :name,            null: false, index: true
      t.json :images,            null: false
      t.text :description,       null: false
      t.string :size
      t.string :condition,       null: false
      t.string :postage,         null: false
      t.string :shipping_method, null: false
      t.string :source_area,     null: false
      t.string :shipping_days,   null: false
      t.integer :price,          null: false
      t.references :buyer_id,    foreign_key: { to_table: :users }
      t.references :seller_id,   foreign_key: { to_table: :users }
      t.references :category_id, foreign_key: true
      t.references :bland_id,    foreign_key: true

      t.timestamps
    end
  end
end
