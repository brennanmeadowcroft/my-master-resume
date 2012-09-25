class AddCurrentFieldToPositions < ActiveRecord::Migration
  def change
  	add_column(:positions, :current, :boolean, default: false)
  end

  def down
  	drop_column(:positions, :current)
  end
end
