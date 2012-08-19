class RemoveUserIdColumnFromExperiences < ActiveRecord::Migration
  def up
  	remove_column :experiences, :user_id
  end

  def down
  	add_column :experiences, :user_id, :integer
  end
end
