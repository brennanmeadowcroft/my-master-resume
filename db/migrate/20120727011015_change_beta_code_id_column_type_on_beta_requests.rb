class ChangeBetaCodeIdColumnTypeOnBetaRequests < ActiveRecord::Migration
  def up
  	change_column :beta_requests, :beta_code_id, :integer
  end

  def down
  	change_column :beta_requests, :beta_code_id, :string
  end
end
