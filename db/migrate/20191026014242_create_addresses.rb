class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string     :firstname,                  null: false
      t.string     :lastname,                   null: false
      t.string     :firstname_kana,             null: false
      t.string     :lastname_kana,              null: false
      t.integer    :postalcode,                 null: false
      t.integer    :prefecture_id,              null: false
      t.string     :city_name,                  null: false
      t.string     :address_number,             null: false
      t.string     :building_name
      t.string     :phone_number
      t.references :user, foreign_key: true, null: false, index: true
      t.timestamps
    end
  end
end


