class ChangeDoctorIdNullableInReports < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reports, :doctor_id, true
  end
end
