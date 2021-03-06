class BetaRequest < ActiveRecord::Base
  attr_accessible :email, :beta_code_id, :approved_at

  belongs_to :beta_codes

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

end
