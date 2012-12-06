class JobDescription < ActiveRecord::Base
  attr_accessible :job_title, :company, :description_string

  has_and_belongs_to_many :analyses
end
