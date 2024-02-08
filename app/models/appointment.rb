class Appointment < ApplicationRecord
  belongs_to :doctor
  has_many :appointment_attachements, dependent: :destroy
  has_many :reports, through: :appointment_attachements
  validates :appointment_date, :content, presence: true

end
