class Sector < ApplicationRecord
  belongs_to :unit
  has_many :employees
  has_many :visits

  scope :active, -> { where(active: true) }
  
  validates :name, presence: true
  validates :unit_id, presence: true

  # callback para desativar os funcionários quando o setor for desativado
  before_update :deactivate_employees_if_inactive, if: :inactive?

  def inactive?
    !self.active
  end

  def deactivate!
    update(active: false)
  end

  def activate!
    update(active: true)
  end

  def deactivate_employees_if_inactive
    if self.employees.present?
      ActiveRecord::Base.transaction do
        employees = self.employees
        employees.each do |employee|
          employee.deactivate!
        end
      end
    end
  end
end
