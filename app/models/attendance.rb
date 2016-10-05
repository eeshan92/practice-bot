class Attendance < ApplicationRecord
  belongs_to :practice
  belongs_to :user
  validates :status, :presence => true
end
