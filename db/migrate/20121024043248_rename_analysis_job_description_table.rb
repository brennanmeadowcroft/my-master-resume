class RenameAnalysisJobDescriptionTable < ActiveRecord::Migration
  def up
  	rename_table :analysis_job_descriptions, :analyses_job_descriptions
  end

  def down
  	rename_table :analyses_job_descriptions, :analysis_job_descriptions
  end
end
