class AddPrintStylesheetColumnToStyles < ActiveRecord::Migration
  def change
    add_column :styles, :print_filename, :string
  end
  def down
  	remove_column :styles, :print_filename
  end
end
