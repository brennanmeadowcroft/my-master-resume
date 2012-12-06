class CreateUserStrings < ActiveRecord::Migration
  def up
    create_table :user_strings do |t|
      t.integer :analysis_id
      t.text :user_string
      t.timestamps
    end
  end

  def down
  	drop_table :user_strings
  end
end
