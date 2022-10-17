class RenameColumnsFromTestsDevices < ActiveRecord::Migration[6.1]
  def change
    rename_column :tests_devices, :result_covid, :result_channel_1
    rename_column :tests_devices, :result_flub, :result_channel_2
    rename_column :tests_devices, :result_flua, :result_channel_3
    rename_column :tests_devices, :result_ipc, :result_channel_4

    rename_column :tests_devices, :time_covid, :time_channel_1
    rename_column :tests_devices, :time_flub, :time_channel_2
    rename_column :tests_devices, :time_flua, :time_channel_3
    rename_column :tests_devices, :time_ipc, :time_channel_4
  end
end
