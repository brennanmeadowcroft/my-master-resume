class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :organization
      t.string :position
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
