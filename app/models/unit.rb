class Unit < ApplicationRecord
    has_many :visitors
    has_many :sectors

    scope :active, -> { where(active: true) }
  
    validates :name, presence: true

    def deactivate!
        update(active: false)
    end

    def activate!
        update(active: true)
    end
end
