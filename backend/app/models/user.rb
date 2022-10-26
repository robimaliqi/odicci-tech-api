class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP,
    message: "must be valid email" }
  validates :date_of_birth, presence: true, validate :dob_must_be_in_the_past


  def dob_must_be_in_the_past
    if Date.parse(date_of_birth) > Date.today
      errors.add(:date_of_birth, "must be in the past")
    end
  end

end