require 'faker'

FactoryGirl.define do
  factory :experience do |f|
  	f.description { Faker::Company.bs }
  	f.position_id 1
  end

  factory :invalid_experience, parent: :experience do |f|
  	f.description nil
  end
end
