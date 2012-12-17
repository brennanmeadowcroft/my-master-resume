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

class Resume < ActiveRecord::Base
  attr_accessible :address, :city, :description, :email, :middle_name, :phone, :style_id, :tag_id, 
  					:user_id, :website, :skill_id

  has_many :analyses, dependent: :destroy
  belongs_to :user
  belongs_to :tag
  belongs_to :skill
  belongs_to :style

  def get_user_info
    info = Hash.new
    contact_class = " hidden"

    if self.middle_name.to_i == 0
      info[:middle_name] = contact_class
    else
      info[:middle_name] = ""
    end

    if self.address.to_i == 0
      info[:address] = contact_class
    else 
      info[:address] = ""
    end
    
    if self.city.to_i == 0
      info[:city] = contact_class
      info[:state] = contact_class
    else
      info[:city] = ""
      info[:state] = ""
    end
    
    if self.email.to_i == 0
      info[:email] = contact_class
    else 
      info[:email] = ""
    end
    
    if self.website.to_i == 0
      info[:website] = contact_class
    else
      info[:website] = ""
    end

    if self.phone.to_i == 0
      info[:phone] = contact_class
    else
      info[:phone] = ""
    end

    return info
  end
end
