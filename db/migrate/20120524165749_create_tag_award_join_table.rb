class CreateTagAwardJoinTable < ActiveRecord::Migration
  def up
  	create_table :tags_awards, :id => false do |t|
  		t.integer :tag_id
  		t.integer :award_id
  	end
  end

  def down
  	drop_table :tags_awards
  end
end
