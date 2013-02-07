require 'faker'

FactoryGirl.define do
  factory :award do |f|
  	f.description "Awesome Award"
  	f.date Date.new(2010, 11)
  	f.user_id 1
  end

  factory :invalid_award, parent: :award do |f|
  	f.description nil
  end
end
