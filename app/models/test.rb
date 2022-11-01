class Test < ApplicationRecord
  belongs_to :user
  has_many :tests_devices, dependent: :destroy
  has_many :result_tests, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many_attached :files

  scope :existence, -> (marker) { where(marker: marker)}
end
