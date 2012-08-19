class AddDetailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :middle_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :address_1, :string
  	add_column :users, :address_2, :string
  	add_column :users, :city, :string
  	add_column :users, :state, :string
  	add_column :users, :zip, :string
  	add_column :users, :phone, :string
  	add_column :users, :website, :string
  end
  def down
  	remove_column :users, :first_name
  	remove_column :users, :middle_name
  	remove_column :users, :last_name
  	remove_column :users, :address_1
  	remove_column :users, :address_2
  	remove_column :users, :city
  	remove_column :users, :state
  	remove_column :users, :zip
  	remove_column :users, :phone
  	remove_column :users, :website
  end
end
