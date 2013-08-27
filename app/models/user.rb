class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
	# name
  validates :name,  presence: true, length: { maximum: 50 }
	# email
  # valid email regex that disallows double dots in email addressed
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
  					format: { with: VALID_EMAIL_REGEX },
  					 uniqueness: { case_sensitive: false }
  # has_secure_password
  validates :password, length: { minimum: 6 }
end