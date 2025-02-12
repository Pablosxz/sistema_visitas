class Employee < ApplicationRecord
  belongs_to :sector
  belongs_to :user
  has_many :visits
end
