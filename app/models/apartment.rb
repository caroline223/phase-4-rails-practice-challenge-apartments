class Apartment < ApplicationRecord
    has_many :tenants, through: :leases

    validates :number, length: { is: 4}
    
end
