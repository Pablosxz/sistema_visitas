class Visit < ApplicationRecord
  belongs_to :visitor
  belongs_to :sector
  belongs_to :employee
  belongs_to :unit

  validates :visit_time, presence: true
  validates :visitor_id, presence: true
  validates :sector_id, presence: true
  validates :unit_id, presence: true
  validates :employee_id, presence: true

  # Método para confirmar a visita
  def confirm!
    update(confirmed_at: Time.current)
  end
end
