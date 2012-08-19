class AddPasswordResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_at, :datetime
  end

  def down
  	remove_column :users, :password_reset_token
  	remove_column :users, :password_reset_at
  end
end
