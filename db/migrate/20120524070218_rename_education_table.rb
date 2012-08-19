class RenameEducationTable < ActiveRecord::Migration
  def up
  	rename_table('educations', 'education')
  end

  def down
  	rename_table('education', 'educations')
  end
end
