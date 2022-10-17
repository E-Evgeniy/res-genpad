class RenameColumnInResultTests < ActiveRecord::Migration[6.1]
  def change
    rename_column :result_tests, :channel, :name_channel_1
    rename_column :result_tests, :volume, :volume_channel_1
  end
end
