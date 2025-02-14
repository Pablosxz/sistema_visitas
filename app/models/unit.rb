class Unit < ApplicationRecord
    has_many :visits
    has_many :sectors
    has_many :users

    scope :active, -> { where(active: true) }
  
    validates :name, presence: true

    # Callback para desativar os setores quando a unidade for desativada
    before_update :deactivate_sectors_and_attendants_if_inactive, if: :inactive?

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
    def deactivate_sectors_and_attendants_if_inactive
        if self.sectors.present?
            ActiveRecord::Base.transaction do
                sectors = self.sectors
                sectors.each do |sector|
                    sector.deactivate!
                end
            end
        end
        if self.users.present?
            ActiveRecord::Base.transaction do
                users = self.users
                users.each do |user|
                    user.destroy!
                end
            end
        end
    end
end
