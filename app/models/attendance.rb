class Attendance < ApplicationRecord
  belongs_to :practice
  belongs_to :user
  validates :status, :presence => true

  enum status: { active: 0, cancelled: 1, pending: 2 }
end
