class RenameTagAwardsTable < ActiveRecord::Migration
  def up
  	rename_table('tags_awards', 'awards_tags')
  end

  def down
  	rename_table('awards_tags', 'tags_awards')
  end
end
