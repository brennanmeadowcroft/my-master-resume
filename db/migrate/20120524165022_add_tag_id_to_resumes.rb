class AddTagIdToResumes < ActiveRecord::Migration
  def change
  	add_column :resumes, :tag_id, :integer
  end
  def down
  	remove_column :resumes, :tag_id
  end
end
