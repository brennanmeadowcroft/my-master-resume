class RenameSkillIdColumnInSkillsTagsTable < ActiveRecord::Migration
  def up
  	rename_column :skills_tags, :skills_id, :skill_id
  end

  def down
  	rename_column :skills_tags, :skill_id, :skills_id
  end
end
