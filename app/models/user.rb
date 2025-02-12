class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :employees, dependent: :destroy, foreign_key: "user_id"

  enum :role, { admin: 0, attendant: 1, employee: 2 } # Enum para definir os papéis dos usuários
end
