# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  email             :string(255)
#  verified          :binary
#  verification_code :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  first_name        :string(255)
#  middle_name       :string(255)
#  last_name         :string(255)
#  address_1         :string(255)
#  address_2         :string(255)
#  city              :string(255)
#  state             :string(255)
#  zip               :string(255)
#  phone             :string(255)
#  website           :string(255)
#  password_digest   :string(255)
#

require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :beta_code_id, :city, :email, :first_name, :last_name, :middle_name, 
                  :linkedin_atoken, :linkedin_id, :linkedin_secret, :password, :password_confirmation, :password_reset_token, 
                  :password_reset_at, :phone, :state, :terms, :verification_code, :verified, :website, :zip
  has_secure_password

# Databse relationships
  has_many :resumes, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :awards, dependent: :destroy
  has_many :education, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :analyses, dependent: :destroy
  belongs_to :beta_codes

# Callbacks
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  before_destroy :destroy_master

# Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create
  validates :first_name, presence: true, :on => :create
  validates :state, length: { maximum: 2 }
  validates_acceptance_of :terms

# Methods
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def make_admin
    self.admin = true
    save!
  end

  def revoke_admin
    self.admin = false
    save!
  end

  def add_linkedin_authentication(uid, token, secret)
    self.linkedin_id = uid
    self.linkedin_atoken = token
    self.linkedin_secret = secret
    save!
  end

  private
    def destroy_master
      errors.add(:base, 'Cannot destroy the master account (User ID = 1)') unless :id != 1
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])    
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end


end
