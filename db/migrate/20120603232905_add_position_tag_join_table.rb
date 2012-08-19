class AddPositionTagJoinTable < ActiveRecord::Migration
  def up
  	create_table :position_tags, :id => false do |t|
  		t.integer :tag_id
  		t.integer :position_id
  	end  	
  end

  def down
  	drop_table :position_tags
  end
end
