class TestsDevice < ApplicationRecord
  scope :existence, -> (marker) { where(marker: marker)}
end
