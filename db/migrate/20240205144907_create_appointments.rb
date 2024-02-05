class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.date :appointment_date
      t.string :content
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
