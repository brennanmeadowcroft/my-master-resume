class AddBaseFieldToStyles < ActiveRecord::Migration
  def change
  	add_column(:styles, :base_style, :binary)
  end

  def down
  	remove_column(:styles, :base_style)
  end
end
