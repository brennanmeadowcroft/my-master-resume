class CreateMasterResumes < ActiveRecord::Migration
  def change
    create_table :master_resumes do |t|

      t.timestamps
    end
  end
end
