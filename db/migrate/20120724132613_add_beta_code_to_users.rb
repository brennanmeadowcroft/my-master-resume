class AddBetaCodeToUsers < ActiveRecord::Migration
  def change
  	remove_column(:users, :beta_code_id)
  	add_column(:users, :beta_code_id, :integer)
  end

  def down
  	remove_column(:users, :beta_code_id)
  end
end
