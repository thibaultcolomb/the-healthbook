class RemoveContentfromAppointments < ActiveRecord::Migration[7.1]
  def change
    remove_column :appointments, :content
  end
end
