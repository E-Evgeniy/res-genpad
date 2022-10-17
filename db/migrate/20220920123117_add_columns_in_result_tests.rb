class AddColumnsInResultTests < ActiveRecord::Migration[6.1]
  def change
    add_column :result_tests, :name_channel_2, :string
    add_column :result_tests, :name_channel_3, :string
    add_column :result_tests, :name_channel_4, :string

    add_column :result_tests, :volume_channel_2, :integer
    add_column :result_tests, :volume_channel_3, :integer
    add_column :result_tests, :volume_channel_4, :integer
  end
end
