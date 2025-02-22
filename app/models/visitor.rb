class Visitor < ApplicationRecord
    has_many :visits

    scope :active, -> { where(active: true) } # Apenas visitantes ativos
    scope :inactive, -> { where(active: false) } # Apenas visitantes inativos

    # Validações
    validates :cpf, presence: true, uniqueness: true, length: { is: 11 }, format: { with: /\A\d+\z/, message: "deve conter apenas números" }
    validates :name, presence: true, length: { minimum: 3, maximum: 100 }
    validates :rg, presence: true, uniqueness: true, format: { with: /\A\d+\z/, message: "deve conter apenas números" }
    validates :phone, presence: true, format: { with: /\A\d{10,11}\z/, message: "deve ter 10 ou 11 dígitos" } # Garante que o telefone tenha 10 ou 11 dígitos numéricos
    validates :photo, presence: true

    # Monta o uploader da foto
    mount_uploader :photo, PhotoUploader

    # Método para desativar visitante
    def deactivate!
        update_column(:active, false)
    end

    # Método para ativar visitante
    def activate!
        update_column(:active, true)
    end
end
