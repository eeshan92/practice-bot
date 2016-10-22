class Attendance < ApplicationRecord
  belongs_to :practice
  belongs_to :player
  validates :status, :practice_id, :player_id, :presence => true

  enum status: { attend: 0, skip: 1, pending: 2 }
end
