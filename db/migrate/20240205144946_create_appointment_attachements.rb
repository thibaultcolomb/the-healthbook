class CreateAppointmentAttachements < ActiveRecord::Migration[7.1]
  def change
    create_table :appointment_attachements do |t|
      t.references :report, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
