class CreateJobDescriptions < ActiveRecord::Migration
  def up
    create_table :job_descriptions do |t|
      t.string :job_title
      t.string :company
      t.string :description_string
      t.timestamps
    end
  end

  def down
  	drop_table :job_descriptions
  end
end
