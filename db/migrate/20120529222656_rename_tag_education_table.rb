class RenameTagEducationTable < ActiveRecord::Migration
  def up
  	rename_table('tags_education', 'education_tags')
  end

  def down
  	rename_table('education_tags', 'tags_education')
  end
end
