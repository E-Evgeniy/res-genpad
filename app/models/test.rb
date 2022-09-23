class Test < ApplicationRecord
  belongs_to :test, class_name: "test", foreign_key: "test_id"
end
