require 'faker'

FactoryGirl.define do
  factory :position do |f|
  	f.company { Faker::Company.name }
  	f.title { Faker::Name.title }
  	f.start_date Date.new(2010, 05)
  	f.end_date Date.new(2011, 05)
  	f.city { Faker::Address.city }
    f.state { Faker::Address.state_abbr }
    f.user_id 1
  end

  factory :invalid_position, parent: :position do |f|
  	f.company nil
  end
end
