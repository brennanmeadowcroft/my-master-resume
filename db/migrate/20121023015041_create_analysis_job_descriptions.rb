class CreateAnalysisJobDescriptions < ActiveRecord::Migration
  def change
    create_table :analysis_job_descriptions do |t|
      t.integer :analysis_id
      t.integer :job_description_id
      t.timestamps
    end
  end

  def down
  	drop_table :analysis_job_descriptions
  end
end
