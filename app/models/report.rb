class Report < ApplicationRecord
  belongs_to :user
  belongs_to :doctor, optional: true

  has_many :appointment_attachements
  has_many :appointments, through: :appointment_attachements

  validates :title, :content, :report_date, :category, presence: true

  validates :category, inclusion: { in: ['Blood test', 'MRI', 'X-Ray', 'Ultrasound', 'Other']}

  include PgSearch::Model
  pg_search_scope :search_by_title, against: [:title], using: { tsearch: { prefix: true } }
end
