class ChangeFilenameColumnToAttachment < ActiveRecord::Migration
  def up
  	remove_column :styles, :screen_filename
  	remove_column :styles, :print_filename

  	add_attachment :styles, :screen_filename
  	add_attachment :styles, :print_filename
  end

  def down
  	remove_attachment :styles, :screen_filename
  	remove_attachment :styles, :print_filename
  	
  	add_column :styles, :screen_filename
  	add_column :styles, :print_filename

  end
end
