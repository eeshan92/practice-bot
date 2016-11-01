class Location < ApplicationRecord
  include Filterable

  has_many :practices

  validates :name, :address, :presence => true

  scope :location_name, ->(name) { where(name: name) }
  scope :address, ->(address) { where(address: address) }
end
