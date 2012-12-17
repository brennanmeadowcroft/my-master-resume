class CreateExperienceSkillJoinTable < ActiveRecord::Migration
  def up
  	create_table :experiences_skills, :id => false do |t|
  		t.integer :skill_id
  		t.integer :experience_id
  	end
  end

  def down
  	drop_table :experiences_skills
  end
end
