class CreateTagExperienceJoinTable < ActiveRecord::Migration
  def up
  	create_table :tags_experiences, :id => false do |t|
  		t.integer :tag_id
  		t.integer :experience_id
  	end
  end

  def down
  	drop_table :tags_experiences
  end
end
