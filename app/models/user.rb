class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :employee, dependent: :destroy  # Um usuário tem um único funcionário

  enum :role, { admin: 0, attendant: 1, employee: 2 } # Enum para definir os papéis dos usuários
end
