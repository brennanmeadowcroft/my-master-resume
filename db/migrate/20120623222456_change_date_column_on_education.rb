class ChangeDateColumnOnEducation < ActiveRecord::Migration
  def up
  	change_column :education, :start_date, :datetime
  	change_column :education, :end_date, :datetime
  end

  def down
  	change_column :education, :start_date, :date
  	change_column :education, :end_date, :date
  end
end
