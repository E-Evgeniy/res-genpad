# frozen_string_literal: true

# Model for users this is system
class User < ApplicationRecord
  has_many :tests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates :first_name, :last_name, presence: true
end
