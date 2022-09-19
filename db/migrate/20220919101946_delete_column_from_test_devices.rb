class DeleteColumnFromTestDevices < ActiveRecord::Migration[6.1]
  def change
    remove_column :tests_devices, :conclusion_covid
    remove_column :tests_devices, :conclusion_flub
    remove_column :tests_devices, :conclusion_flua
    remove_column :tests_devices, :conclusion_ipc
    remove_column :tests_devices, :conclusion_monkeypox
    remove_column :tests_devices, :volume_covid
    remove_column :tests_devices, :volume_flub
    remove_column :tests_devices, :volume_lua
    remove_column :tests_devices, :volume_ipc
    remove_column :tests_devices, :volume_monkeypox
    remove_column :tests_devices, :marker
  end
end



