class Test < ApplicationRecord
  belongs_to :code
  belongs_to :user
  has_many :hash_test_device
end
