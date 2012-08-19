class RenameFilenameColumnInStyles < ActiveRecord::Migration
  def up
  	rename_column :styles, :filename, :screen_filename
  end

  def down
  	rename_column :styles, :screen_filename, :filename
  end
end
