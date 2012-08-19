class RenameTagSkillsTable < ActiveRecord::Migration
  def up
  	rename_table('tags_skills', 'skills_tags')
  end

  def down
  	rename_table('skills_tags', 'tags_skills')
  end
end
