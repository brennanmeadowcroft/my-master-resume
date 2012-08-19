class RenameTagActivitiesTable < ActiveRecord::Migration
  def up
  	rename_table('tags_activities', 'activities_tags')
  end

  def down
  	rename_table('activities_tags', 'tags_activities')
  end
end
