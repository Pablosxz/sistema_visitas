class Sector < ApplicationRecord
  belongs_to :unit
  has_many :employees
  has_many :visits

  scope :active, -> { where(active: true) }
  
  validates :name, presence: true
  validates :unit_id, presence: true

  def deactivate!
    update(active: false)
  end

  def activate!
    update(active: true)
  end
end
