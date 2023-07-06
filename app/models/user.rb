# has a password and an email

class User < ApplicationRecord
  has_secure_password

  validates :email ,  presence: true, format: {with: URI::MailTo::EMAIL_REGEXP , message: "must enter a valid email address "}
  validates :password, length: { in: 6..20 }

end
