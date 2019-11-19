class CreateCreditcards < ActiveRecord::Migration[5.2]
  def change
    create_table :creditcards do |t|
      t.references :user,  foreign_key: true, null: false
      t.string :customer_id, null: false
      t.timestamps
    end
  end
end
