class Student < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[a-z]{2,}\z/i
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "eamil id is invalid" }
  validates :phone_no, presence: true
end
