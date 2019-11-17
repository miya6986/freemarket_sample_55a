class AddUserReferenceToSnsCredential < ActiveRecord::Migration[5.2]
  def change
    add_reference :sns_credential, :user, null: false, foreign_key: true
  end
end
