class ChangeDataTypeOnJobDescriptions < ActiveRecord::Migration
  def up
  	change_column :job_descriptions, :description_string, :text
  end

  def down
  	change_column :job_descriptions, :description_string, :string
  end
end
