class CreateTestsDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :tests_devices do |t|
      t.integer :device_id
      t.string :marker, unique: true
      t.timestamp :date_test
      t.string :sample_barcode
      t.integer :threshold
      t.string :result_covid
      t.string :result_flub
      t.string :result_flua
      t.string :result_ipc
      t.string :result_monkeypox
      t.string :conclusion_covid
      t.string :conclusion_flub
      t.string :conclusion_flua
      t.string :conclusion_ipc
      t.string :conclusion_monkeypox
      t.integer :volume_covid
      t.integer :volume_flub
      t.integer :volume_lua
      t.integer :volume_ipc
      t.integer :volume_monkeypox
      t.string :status

      t.timestamps
    end
  end
end
