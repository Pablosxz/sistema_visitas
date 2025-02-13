class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :employee # Um usuário tem um único funcionário

  belongs_to :unit, optional: true  # unit_id pode ser nulo

  # Validação: apenas atendentes devem ter `unit_id`
  validates :unit_id, presence: true, if: -> { attendant? }

  enum :role, { admin: 0, attendant: 1, employee: 2 } # Enum para definir os papéis dos usuários
end
