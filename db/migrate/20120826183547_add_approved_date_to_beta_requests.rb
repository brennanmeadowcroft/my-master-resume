class AddApprovedDateToBetaRequests < ActiveRecord::Migration
  def up
  	add_column(:beta_requests, :approved_at, :datetime)
  end
  def down
  	remove_column(:beta_requests, :approved_at)
  end
end
