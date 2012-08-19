class ChangeDateColumnOnAwards < ActiveRecord::Migration
  def up
  	change_column :awards, :date, :datetime
  end

  def down
  	change_column :awards, :date, :date
  end
end
