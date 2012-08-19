class AddUserIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :user_id, :integer
  end
  def down
  	remove_column :tags, :user_id
  end
end
