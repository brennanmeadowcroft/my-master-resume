class AddUserIdToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :user_id, :integer
  end
  def down
  	remove_column :activities, :user_id
  end
end
