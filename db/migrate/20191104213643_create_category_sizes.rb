class CreateCategorySizes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizes do |t|
      t.references :category, null:false
      t.references :size,     null:false
      t.timestamps
    end
  end
end
