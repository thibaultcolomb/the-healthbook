class Doctor < ApplicationRecord
  belongs_to :user

  has_many :reports, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :first_name, :last_name, :specialty, :email, presence: true
  validates :specialty, inclusion: { in: %w[Internal Medicine Surgery Pediatrics Radiology]}
end
