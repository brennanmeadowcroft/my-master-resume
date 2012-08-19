class RenamePositionTagsTable < ActiveRecord::Migration
  def up
  	rename_table :position_tags, :positions_tags
  end

  def down
  	rename_table :positions_tags, :position_tags
  end
end
