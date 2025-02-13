class Visit < ApplicationRecord
  belongs_to :visitor
  belongs_to :sector
  belongs_to :employee, dependent: :destroy
  belongs_to :unit

  validates :visit_time, presence: true

  # Método para confirmar a visita
  def confirm!
    update(confirmed_at: Time.current)
  end
end
