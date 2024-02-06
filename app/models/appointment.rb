class Appointment < ApplicationRecord
  belongs_to :doctor
  has_many :users
  has_many :reports, through: :appointment_attachements

  validates :date, :content, presence: true
end
