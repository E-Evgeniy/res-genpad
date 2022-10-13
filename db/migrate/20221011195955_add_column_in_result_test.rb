class AddColumnInResultTest < ActiveRecord::Migration[6.1]
  def change
    add_column :result_tests, :unit_of_time, :integer
  end
end
