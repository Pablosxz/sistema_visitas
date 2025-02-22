class Employee < ApplicationRecord
  belongs_to :sector
  belongs_to :user, optional: true
  has_many :visits

  # Escopo para buscar apenas funcionários ativos e inativos
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  # Aceita atributos aninhados para o usuário
  accepts_nested_attributes_for :user

  # Validações
  validates :name, presence: true
  validates :sector_id, presence: true

  # Callback para destruir o usuário quando o funcionário for desativado
  before_update :destroy_user_if_inactive, if: :inactive?

  # Método que verifica se o funcionário está inativo
  def inactive?
    !self.active
  end

  # Método para verificar se o funcionário está ativo
  def active?
    self.active
  end

  # Método para destruir o usuário associado
  def destroy_user_if_inactive
    if self.user.present?
      ActiveRecord::Base.transaction do
        user = self.user
        self.update(user_id: nil) # Define user_id como nil
        user.destroy! # Destroi o usuário
      end
    end
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
