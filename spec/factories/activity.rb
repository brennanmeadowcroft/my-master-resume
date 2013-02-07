require 'faker'

FactoryGirl.define do
  factory :activity do |f|
  	f.organization { Faker::Company.name }
  	f.start_date Date.new(2010, 11)
  	f.end_date Date.new(2011, 11)
  	f.user_id 1
  end

  factory :invalid_activity, parent: :activity do |f|
  	f.organization nil
  end
end
