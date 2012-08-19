class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :description
      t.string :filename

      t.timestamps
    end
  end
end
