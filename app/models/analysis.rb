class Analysis < ActiveRecord::Base
   attr_accessible :user_id, :resume_id

   has_many :user_strings 
   has_and_belongs_to_many :job_descriptions
   belongs_to :user
   belongs_to :resume
end
