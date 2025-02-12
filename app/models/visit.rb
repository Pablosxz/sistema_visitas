class Visit < ApplicationRecord
  belongs_to :visitor
  belongs_to :sector
  belongs_to :employee, optional: true
  belongs_to :unit

  validates :visit_time, presence: true
end
