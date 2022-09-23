class Code < ApplicationRecord
  has_many :tests
  
  validates :code, presence: true  
end
