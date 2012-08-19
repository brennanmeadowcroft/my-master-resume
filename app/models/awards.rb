class Awards < ActiveRecord::Base
  attr_accessible :date, :description, :user_id
end
