class Doctor < ApplicationRecord
  belongs_to :user

  has_many :reports, dependent: :destroy
  has_many :appointments, dependent: :destroy

  validates :first_name, :last_name, :specialty, :email, presence: true

  validates :specialty, inclusion: { in: ["Internal Medicine", "Surgery", "Pediatrics", "Obstetrics and Gynecology", "Psychiatry", "Radiology", "Anesthesiology", "Emergency Medicine",
                                             "Pathology", "Ophthalmology", "Otolaryngology (ENT)", "Dermatology", "Neurology",
                                            "Urology", "Orthopedics", "Physical Medicine and Rehabilitation", "Allergy and Immunology",
                                             "Infectious Diseases", "Endocrinology", "Cardiology"]
                                    }
end
