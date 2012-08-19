class AddDescriptionToBetaCodes < ActiveRecord::Migration
  def change
  	add_column(:beta_codes, :description, :string)
  end
  def down
  	remove_column(:beta_codes, :description, :string)
  end
end
