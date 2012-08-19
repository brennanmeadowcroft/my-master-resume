class AddCodeSentFieldToBetaRequests < ActiveRecord::Migration
  def change
  	add_column :beta_requests, :sent_code, :string
  end
  def down
  	remove_column :beta_requests, :sent_code
  end
end
