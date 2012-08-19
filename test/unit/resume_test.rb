# == Schema Information
#
# Table name: resumes
#
#  id          :integer         not null, primary key
#  description :string(255)
#  middle_name :binary
#  address     :binary
#  city        :binary
#  email       :binary
#  website     :binary
#  phone       :binary
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#  style_id    :integer
#  tag_id      :integer
#

require 'test_helper'

class ResumeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
