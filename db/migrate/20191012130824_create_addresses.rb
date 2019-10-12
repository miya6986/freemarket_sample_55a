class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string     :address_firstname,          null: false
      t.string     :address_lastname,           null: false
      t.string     :address_firstname_kana,     null: false
      t.string     :address_lastname_kana,      null: false
      t.integer    :postalcode,                 null: false
      t.integer    :prefecture_id,              null: false
      t.string     :city_name,                  null: false
      t.string     :address_number,             null: false
      t.string     :building_name              
      t.string     :address_phone_number       
      t.references :user, foreign_key: true, null: false, index: true
      t.timestamps
    end
  end
end


