class CreateTagActivityJoinTable < ActiveRecord::Migration
  def up
  	create_table :tags_activities, :id => false do |t|
  		t.integer :tag_id
  		t.integer :activity_id
  	end
  end

  def down
  	drop_table :tags_activities
  end
end
