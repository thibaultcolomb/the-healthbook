# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# 1. Seeds for users
# 2. Seeds for doctors
# 3. Seeds for appointments


harri = User.new(
  email: 'harri@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Harri',
  last_name: 'Potter'
)
harri.save!

specialty = %w[Internal, Medicine, Surgery, Pediatrics, Obstetrics and Gynecology, Psychiatry, Radiology, Anesthesiology, Emergency Medicine, Pathology, Ophthalmology, Otolaryngology (ENT), Dermatology, Neurology , Urology, Orthopedics, Physical Medicine and Rehabilitation, Allergy and Immunology, Infectious Diseases, Endocrinology, Cardiology]

Doctor.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  specialty: specialty.sample,
  email: Faker::Internet.email,
  user_id: harri.id
)

Report.new(
  title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph,
  report_date: Faker::Date.between(from: Date.today, to: 1.month.from_now),
  category: specialty.sample,
  user_id: harri.id,
  doctor_id: harri.doctors.sample.id
)
