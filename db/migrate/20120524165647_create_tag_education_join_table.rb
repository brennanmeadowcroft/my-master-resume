class CreateTagEducationJoinTable < ActiveRecord::Migration
  def up
  	create_table :tags_education, :id => false do |t|
  		t.integer :tag_id
  		t.integer :education_id
  	end
  end

  def down
  	drop_table :tags_education
  end
end
