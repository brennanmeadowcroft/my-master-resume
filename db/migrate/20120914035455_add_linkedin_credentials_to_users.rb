class AddLinkedinCredentialsToUsers < ActiveRecord::Migration
  def up
  	add_column(:users, :linkedin_atoken, :string)
  	add_column(:users, :linkedin_id, :string)
  	add_column(:users, :linkedin_secret, :string)
  end
  def down
  	remove_column(:users, :linkedin_atoken, :string)
  	remove_column(:users, :linkedin_id, :string)
  	remove_column(:users, :linkedin_secret, :string)
  end
end
