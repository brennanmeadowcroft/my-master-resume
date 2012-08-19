class CreateBetaCodes < ActiveRecord::Migration
  def change
    create_table :beta_codes do |t|
      t.string :code

      t.timestamps
    end
  end
end
