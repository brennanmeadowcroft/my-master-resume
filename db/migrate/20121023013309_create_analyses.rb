class CreateAnalyses < ActiveRecord::Migration
  def up
    create_table :analyses do |t|
      t.integer :user_id
      t.integer :resume_id

      t.timestamps
    end
  end
  def down
  	drop_table :analyses
  end
end
