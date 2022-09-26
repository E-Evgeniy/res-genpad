class AddColumnInTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :fluid, :string
  end
end
