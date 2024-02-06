class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  has_many :reports, through: :appointment_attachements

  validates :appointment_date, :content, presence: true

end
