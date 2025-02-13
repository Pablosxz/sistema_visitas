class Employee < ApplicationRecord
  belongs_to :sector
  belongs_to :user
  has_many :visits

  # Escopo para buscar apenas funcionários ativos
  scope :active, -> { where(active: true) }

  # Validações
  validates :name, presence: true
  validates :sector_id, presence: true
  validates :user_id, presence: true
  
  # Método para verificar se o funcionário está ativo
  def active?
    active
  end

  # Método para desativar funcionário
  def deactivate!
    update(active: false)
  end
  
  # Método para ativar funcionário
  def activate!
    update(active: true)
  end
end
