class CreateAwardSkillJoinTable < ActiveRecord::Migration
  def up
  	create_table :awards_skills, :id => false do |t|
  		t.integer :skill_id
  		t.integer :award_id
  	end
  end

  def down
  	drop_table :awards_skills
  end
end
