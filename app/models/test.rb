class Test < ApplicationRecord
  belongs_to :user
  has_many :hash_test_device

  scope :existence, -> (marker) { where(marker: marker)}
end
