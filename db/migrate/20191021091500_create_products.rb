class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name,            null: false, index: true
      t.text :description,       null: false
      t.string :size
      t.string :condition,       null: false
      t.string :postage,         null: false
      t.string :shipping_method, null: false
      t.integer :prefecture_id,  null: false
      t.string :shipping_days,   null: false
      t.integer :price,          null: false
      t.references :buyer,    foreign_key: { to_table: :users }
      t.references :seller,   foreign_key: { to_table: :users }
      # t.references :category, foreign_key: true
      # t.references :bland,    foreign_key: true

      t.timestamps
    end
  end
end
