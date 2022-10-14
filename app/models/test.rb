class Test < ApplicationRecord
  belongs_to :user
  has_many :tests_devices, dependent: :destroy
  has_many :result_tests, dependent: :destroy

  scope :existence, -> (marker) { where(marker: marker)}
end
