class CreateResultTests < ActiveRecord::Migration[6.1]
  def change
    create_table :result_tests do |t|
      t.integer :device_id
      t.references :test, foreign_key: true
      t.timestamp :date_test
      t.string :channel
      t.integer :volume

      t.timestamps
    end
  end
end
