class Positions < ActiveRecord::Base
  attr_accessible :city, :company, :end_date, :start_date, :state, :title, :user_id
end
