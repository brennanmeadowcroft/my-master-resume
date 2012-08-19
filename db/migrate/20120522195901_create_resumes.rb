class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.string :description
      t.binary :middle_name
      t.binary :address
      t.binary :city
      t.binary :email
      t.binary :website
      t.binary :phone

      t.timestamps
    end
  end
end
