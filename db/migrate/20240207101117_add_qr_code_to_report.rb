class AddQrCodeToReport < ActiveRecord::Migration[7.1]
  def change
    add_column :reports, :qr_code, :string
  end
end
