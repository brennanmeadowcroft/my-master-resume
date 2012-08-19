class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :user_id
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
