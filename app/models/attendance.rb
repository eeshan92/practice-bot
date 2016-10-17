class Attendance < ApplicationRecord
  belongs_to :practice
  belongs_to :user
  validates :status, :presence => true

  enum status: { attend: 0, skip: 1, pending: 2 }
end
