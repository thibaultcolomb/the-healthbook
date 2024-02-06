class AddTimeToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :time, :time
  end
end
