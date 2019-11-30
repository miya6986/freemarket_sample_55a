class ChangeDatatypePostalcodeOfAddresses < ActiveRecord::Migration[5.2]
  def change
    change_column :addresses, :postalcode, :string
  end
end
