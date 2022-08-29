# frozen_string_literal: true

# Model for users this is system
class User < ApplicationRecord
  validates :first_name, :last_name, presence: true
end
