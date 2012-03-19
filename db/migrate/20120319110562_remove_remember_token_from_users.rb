class RemoveRememberTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :remember_token if column_exists?(:users, :remember_token)
  end
end