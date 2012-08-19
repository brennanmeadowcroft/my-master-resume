class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :school
      t.string :city
      t.string :state
      t.string :degree
      t.string :major
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
