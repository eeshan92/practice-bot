class Attendance < ApplicationRecord
  include Filterable

  belongs_to :practice
  belongs_to :player

  validates :status, :practice_id, :player_id, :presence => true

  enum status: { attend: 0, skip: 1, pending: 2, late: 3, other: 4 }

  scope :status, ->(status) { where(status: Attendance.statuses[status]) }
  scope :practice_id, ->(id) { where practice_id: id }
  scope :player_id, ->(id) { where player_id: id }

  def as_json(options={})
      super(:include => {
              :player => {
                :only => [:handle, :full_name, :gender]
              },
              :practice => {
                :only => [:date]
              }
            }
      )
    end
end
