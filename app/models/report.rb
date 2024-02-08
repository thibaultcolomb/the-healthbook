class Report < ApplicationRecord
  belongs_to :user
  belongs_to :doctor, optional: true

  has_many :appointment_attachements
  has_many :appointments, through: :appointment_attachements

  validates :title, :report_date, :category, presence: true

  validates :category, inclusion: { in: ['Blood Tests', 'Imaging', 'Surgery', 'Pathology', 'Cardiology', 'Endoscopy', 'Pulmonary Function Test (PFT)', 'Genetic Testing', 'Allergy Testing', 'Neurological', 'Dermatology', 'Obstetric and Gynecological', 'Urology', 'Orthopedic', 'Gastroenterology', 'Ophthalmology', 'Nuclear Medicine', 'Psychiatric', 'Rehabilitation', 'Dental'] }

  include PgSearch::Model
  pg_search_scope :search_by_title, against: [:title], using: { tsearch: { prefix: true } }

  has_one_attached :photo
  has_one_attached :pdf
end
