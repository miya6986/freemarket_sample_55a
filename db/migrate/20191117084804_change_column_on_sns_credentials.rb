class ChangeColumnOnSnsCredentials < ActiveRecord::Migration[5.2]
  def change
    change_column_null :sns_credentials, :uid, false
    change_column_null :sns_credentials, :provider, false
    remove_foreign_key :sns_credentials, :users
    remove_reference :sns_credentials, :user, index: true
  end
end
