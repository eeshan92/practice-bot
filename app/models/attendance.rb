class Attendance < ApplicationRecord
  include Filterable

  belongs_to :practice
  belongs_to :player

  validates :status, :practice_id, :player_id, :presence => true

  enum status: { attend: 0, skip: 1, pending: 2 }

  scope :status, ->(status) { where(status: Attendance.statuses[status]) }
  scope :practice_id, ->(id) { where practice_id: id }
  scope :player_id, ->(id) { where player_id: id }
end
