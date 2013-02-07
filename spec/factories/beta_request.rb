require 'faker'

FactoryGirl.define do
  factory :beta_request do |f|
  	f.email { Faker::Internet.email }
  end

  factory :invalid_beta_request, parent: :beta_request do |f|
  	f.email nil
  end
end
