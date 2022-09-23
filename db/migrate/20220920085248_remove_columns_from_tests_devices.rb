class RemoveColumnsFromTestsDevices < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests_devices, :result_none
    remove_column :tests_devices, :time_none
    remove_column :tests_devices, :time_monkeypox
    remove_column :tests_devices, :result_monkeypox
  end
end
