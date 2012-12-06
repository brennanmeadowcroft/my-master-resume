class UserString < ActiveRecord::Base
  attr_accessible :analysis_id, :user_string

  belongs_to :analysis
end
