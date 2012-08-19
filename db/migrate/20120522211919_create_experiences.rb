class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.integer :position_id
      t.string :description

      t.timestamps
    end
  end
end
