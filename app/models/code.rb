class Code < ApplicationRecord
  has_many :tests
  
  validates :code, presence: true  
  scope :existence, -> (code) { where(code: code)}
end
