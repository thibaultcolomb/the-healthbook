class RenameContentToNote < ActiveRecord::Migration[7.1]
  def change
    rename_column :reports, :content, :note
  end
end
