class Attendance < ApplicationRecord
  include Filterable

  belongs_to :practice
  belongs_to :player
  validates :status, :practice_id, :player_id, :presence => true

  enum status: { attend: 0, skip: 1, pending: 2 }

  scope :practice_id, ->(id) { where practice_id: id }
  scope :player_id, ->(id) { where player_id: id }
  scope :status, ->(status) { where status: status }

  validates :status,
    on: [:create, :update],
    inclusion: {
      in: ["attend", "skip", "pending"],
      message: "Invalid value for status"
    }
end
