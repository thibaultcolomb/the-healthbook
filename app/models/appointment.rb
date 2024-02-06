class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user, through: :doctors
  has_many :reports, through: :appointment_attachements

  validates :appointment_date, :content, presence: true
end
