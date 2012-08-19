class RenameTagExperiencesTable < ActiveRecord::Migration
  def up
  	rename_table('tags_experiences', 'experiences_tags')
  end

  def down
  	rename_table('experience_tags', 'tags_experiences')
  end
end
