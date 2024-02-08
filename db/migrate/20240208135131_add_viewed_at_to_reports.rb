class AddViewedAtToReports < ActiveRecord::Migration[7.1]
  def change
    add_column :reports, :viewed_at, :datetime
  end
end
