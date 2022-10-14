class TestsDevice < ApplicationRecord
  belongs_to :test
  
  scope :existence, -> (marker) { where(marker: marker)}
end
