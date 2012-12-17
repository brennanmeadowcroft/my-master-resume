class CreateActivitySkillJoinTable < ActiveRecord::Migration
  def up
  	create_table :activities_skills, :id => false do |t|
  		t.integer :skill_id
  		t.integer :activity_id
  	end
  end

  def down
  	drop_table :activities_skills
  end
end
