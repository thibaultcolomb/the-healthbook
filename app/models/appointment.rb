class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_tp :user, through: :doctors
  has_many :reports, through: :appointment_attachements

  validates :date, :content, presence: true
end
