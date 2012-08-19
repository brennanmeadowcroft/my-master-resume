class AddUserIdToResumes < ActiveRecord::Migration
  def change
  	add_column :resumes, :user_id, :integer
  end
  def down
  	remove_column :resumes, :user_id
  end
end
