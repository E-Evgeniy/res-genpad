class AddColInTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :header, :string
  end
end
