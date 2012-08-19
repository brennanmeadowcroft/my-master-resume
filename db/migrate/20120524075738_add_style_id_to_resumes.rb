class AddStyleIdToResumes < ActiveRecord::Migration
  def change
	add_column :resumes, :style_id, :integer
  end
  def down
  	remove_column :resumes, :style_id
  end
end
