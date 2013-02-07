require 'faker'

FactoryGirl.define do
  factory :tag do |f|
  	f.description "Marketing"
  	f.user_id 1
  end

  factory :invalid_tag, parent: :tag do |f|
  	f.description nil
  end
end
