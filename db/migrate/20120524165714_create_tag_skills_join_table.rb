class CreateTagSkillsJoinTable < ActiveRecord::Migration
  def up
  	create_table :tags_skills, :id => false do |t|
  		t.integer :tag_id
  		t.integer :skills_id
  	end
  end

  def down
  	drop_table :tags_skills
  end
end
