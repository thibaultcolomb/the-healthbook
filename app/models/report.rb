class Report < ApplicationRecord
  belongs_to :user
  belongs_to :doctor, optional: true

  belongs_to :appointment, through: :appointment_attachements

  validates :title, :content, :date, :category, presence: true

  validates :specialty, inclusion: { in: %w[Blood Tests, Imaging Reports, Surgery Reports, Pathology Reports, Cardiology Reports, Endoscopy Reports, Pulmonary Function Test (PFT) Reports, Genetic Testing Reports, Allergy Testing Reports
    Neurological Reports, Dermatology Reports, Obstetric and Gynecological Reports, Urology Reports, Orthopedic Reports, Gastroenterology Reports, Ophthalmology Reports, Nuclear Medicine Reports, Psychiatric Reports, Rehabilitation Reports, Dental Reports] }
end
