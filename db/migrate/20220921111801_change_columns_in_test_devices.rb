class ChangeColumnsInTestDevices < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests_devices, :time_channel_1
    remove_column :tests_devices, :time_channel_2
    remove_column :tests_devices, :time_channel_3
    remove_column :tests_devices, :time_channel_4

    add_column :tests_devices, :time_channel_1, :string
    add_column :tests_devices, :time_channel_2, :string
    add_column :tests_devices, :time_channel_3, :string
    add_column :tests_devices, :time_channel_4, :string
  end
end
