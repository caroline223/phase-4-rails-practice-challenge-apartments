class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :apartment_id, :tenant_id, :rent

  belongs_to :tenant 
  belongs_to :apartment
end
