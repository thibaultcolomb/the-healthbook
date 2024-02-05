class AppointmentAttachement < ApplicationRecord
  belongs_to :report
  belongs_to :appointment
end
