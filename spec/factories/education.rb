require 'faker'

FactoryGirl.define do
  factory :education do |f|
  	f.school "#{ Faker::Company.name } Institute of Technology"
  	f.major "Business"
  	f.degree "Bachelors"
    f.city { Faker::Address.city }
    f.state { Faker::Address.state_abbr }
  	f.start_date Date.new(2001, 9)
  	f.end_date Date.new(2005, 5)
    f.user_id 1
  end

  factory :invalid_education, parent: :education do |f|
    f.school nil
  end
end
