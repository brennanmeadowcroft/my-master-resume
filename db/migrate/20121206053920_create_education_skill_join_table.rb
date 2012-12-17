class CreateEducationSkillJoinTable < ActiveRecord::Migration
  def up
  	create_table :education_skills, :id => false do |t|
  		t.integer :skill_id
  		t.integer :education_id
  	end
  end

  def down
  	drop_table :education_skills
  end

end
