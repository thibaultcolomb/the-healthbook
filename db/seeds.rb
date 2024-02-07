# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'faker' # Include Faker gem at the beginning

specialty = ["Internal Medicine", "Surgery", "Pediatrics", "Radiology"]

category = ['Blood Tests', 'Imaging', 'Surgery', 'Pathology', 'Cardiology', 'Endoscopy', 'Pulmonary Function Test (PFT)', 'Genetic Testing', 'Allergy Testing', 'Neurological', 'Dermatology', 'Obstetric and Gynecological', 'Urology', 'Orthopedic', 'Gastroenterology', 'Ophthalmology', 'Nuclear Medicine', 'Psychiatric', 'Rehabilitation', 'Dental'] 

harri = User.create!(
  email: 'harri@gmail.com',
  password: 'password',

  password_confirmation: 'password',
  first_name: 'Harri',
  last_name: 'Besceli'

)

thibault = User.create!(
  email: 'thibault@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Thibault',
  last_name: 'C'
)

kemi = User.create!(
  email: 'kemi@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Kemi',
  last_name: 'O'
)

julia = User.create!(
  email: 'julia@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Julia',
  last_name: 'P'
)

users = [harri, thibault, kemi, julia]

users.each do |user|
  4.times do
    doctor = Doctor.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      specialty: specialty.sample,
      email: Faker::Internet.email,
      user_id: user.id
    )
  end

  3.times do
    appointment = Appointment.create!(
      appointment_date: Faker::Time.between(from: Date.today, to: 1.month.from_now),
      content: Faker::Lorem.sentence(word_count: 3),
      doctor_id: user.doctors.sample.id,

    )
  end

  2.times do
    report = Report.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      content: Faker::Lorem.paragraph(sentence_count: 2),
      report_date: Faker::Date.between(from: Date.today, to: 1.month.from_now),
      category: category.sample,
      user_id: user.id,
      doctor_id: user.doctors.sample.id
    )
  end

  report = Report.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2),
    report_date: Faker::Date.between(from: Date.today, to: 1.month.from_now),
    category: category.sample,
    user_id: user.id,
    doctor_id: user.doctors.sample.id
  )
end

puts 'Seeds created!'
