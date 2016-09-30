class Practice < ApplicationRecord
  belongs_to :location

  validates :location_id, :presence => true

  enum status: { active: 0, cancelled: 1, pending: 2 }
end
