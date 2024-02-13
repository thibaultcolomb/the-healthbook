class Appointment < ApplicationRecord
  belongs_to :doctor
  accepts_nested_attributes_for :doctor
  validates_associated :doctor
  has_many :appointment_attachements, dependent: :destroy
  has_many :reports, through: :appointment_attachements
  validates :appointment_date, presence: true

end
