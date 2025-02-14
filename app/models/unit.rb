class Unit < ApplicationRecord
    has_many :visits
    has_many :sectors

    scope :active, -> { where(active: true) }
  
    validates :name, presence: true

    # Callback para desativar os setores quando a unidade for desativada
    before_update :deactivate_sectors_if_inactive, if: :inactive?

    def inactive?
        !self.active
    end

    def deactivate!
        update(active: false)
    end

    def activate!
        update(active: true)
    end

    # Método para desativar os setores associados junto com a unidade
    def deactivate_sectors_if_inactive
        if self.sectors.present?
            ActiveRecord::Base.transaction do
                sectors = self.sectors
                sectors.each do |sector|
                    sector.deactivate!
                end
            end
        end
    end
end
