class AddColoumnsInTestsDevices1 < ActiveRecord::Migration[6.1]
  def change
    add_column :tests_devices, :name_channel_1, :string
    add_column :tests_devices, :name_channel_2, :string
    add_column :tests_devices, :name_channel_3, :string
    add_column :tests_devices, :name_channel_4, :string
  end
end
