class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  has_many :reports, through: :appointment_attachements
  validates :date, :content, presence: true
end
