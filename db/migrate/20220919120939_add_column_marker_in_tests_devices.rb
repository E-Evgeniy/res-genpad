class AddColumnMarkerInTestsDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :tests_devices, :marker, :string
  end
end
