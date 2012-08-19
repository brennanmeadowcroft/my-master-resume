# == Schema Information
#
# Table name: education
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  school     :string(255)
#  city       :string(255)
#  state      :string(255)
#  degree     :string(255)
#  major      :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Education do
  pending "add some examples to (or delete) #{__FILE__}"
end
