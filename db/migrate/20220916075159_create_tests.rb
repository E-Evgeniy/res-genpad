class CreateTests < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :marker, unique: true
      t.string :configuration_number
      t.string :configuration_text
      t.string :cartridge_type
      t.string :reagent
      t.date :production_date
      t.date :testing_date
      t.string :conclusion
      t.string :description

      t.timestamps
    end
  end
end
