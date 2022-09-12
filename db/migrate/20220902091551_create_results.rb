class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :marker
      t.string :configuration
      t.references :code, foreign_key: true
      t.string :user_testing
      t.references :user, foreign_key: true
      t.timestamp :test_date
      t.integer :device_id
      t.string :covid
      t.string :flub
      t.string :flua
      t.string :ipc
      t.string :status
      t.string :date_chip
      t.string :text_header_1
      t.string :text_header_2

      t.timestamps
    end
  end
end
