class AddThresholdToCode < ActiveRecord::Migration[6.1]
  def change
    add_column :codes, :threshold, :integer
  end
end
