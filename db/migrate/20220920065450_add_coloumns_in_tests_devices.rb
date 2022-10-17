class AddColoumnsInTestsDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :tests_devices, :time_covid, :integer
    add_column :tests_devices, :time_flub, :integer
    add_column :tests_devices, :time_flua, :integer
    add_column :tests_devices, :time_ipc, :integer
    add_column :tests_devices, :time_monkeypox, :integer
    add_column :tests_devices, :time_none, :integer
    add_column :tests_devices, :result_none, :string
  end
end
