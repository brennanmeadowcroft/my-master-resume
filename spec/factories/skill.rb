require 'faker'

FactoryGirl.define do
  factory :skill do |f|
  	f.description { Faker::Company.catch_phrase }
  	f.user_id 1
  end

  factory :invalid_skill, parent: :skill do |f|
  	f.description nil
  end
end
