require 'faker'

FactoryGirl.define do
  factory :resume do |f|
  	f.description "Test Resume"
  	f.style_id 1
  	f.tag_id 1
  	f.user_id 1
  end

  factory :invalid_resume, parent: :resume do |f|
  	f.tag_id nil
  end
end
