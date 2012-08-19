class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :user_id
      t.string :title
      t.string :company
      t.string :city
      t.string :state
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
