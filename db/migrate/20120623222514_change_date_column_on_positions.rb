class ChangeDateColumnOnPositions < ActiveRecord::Migration
  def up
  	change_column :positions, :start_date, :datetime
  	change_column :positions, :end_date, :datetime
  end

  def down
  	change_column :positions, :start_date, :date
  	change_column :positions, :end_date, :date
  end
end
