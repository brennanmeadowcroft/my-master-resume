class RenameCodeSentColumnInBetaRequests < ActiveRecord::Migration
  def up
  	rename_column :beta_requests, :sent_code, :beta_code_id
  end

  def down
  	rename_column :beta_requests, :beta_code_id, :sent_code
  end
end
