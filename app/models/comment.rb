class Comment < ApplicationRecord
  belongs_to :test
  belongs_to :user

  validates :body, presence: true
end
