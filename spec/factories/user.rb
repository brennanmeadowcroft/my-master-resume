require 'faker'

FactoryGirl.define do
  factory :user do |f|
  	f.first_name { Faker::Name.first_name }
  	f.last_name { Faker::Name.last_name }
  	f.email { Faker::Internet.email }
  	f.password "foobar"
  	f.password_confirmation "foobar"
    f.beta_code_id 1
    f.remember_token 123456
  end

  factory :invalid_user, parent: :user do |f|
  	f.first_name nil
  end

  factory :admin, parent: :user do |f|
    f.admin true
  end
end
