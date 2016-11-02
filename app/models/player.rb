class Player < ApplicationRecord
  include Filterable
  attr_accessor :attendance_record

  has_many :attendances

  validates :full_name, presence: true

  enum gender: { male: 0, female: 1 }

  scope :full_name, ->(full_name) { where full_name: full_name }
  scope :handle, ->(handle) { where handle: handle }
  scope :foreign_id, ->(id) { where foreign_id: id }
  scope :gender, ->(gender) { where gender: gender }
  scope :phone, ->(phone) { where phone: phone }
  scope :NRIC, ->(nric) { where NRIC: nric }
  scope :email, ->(email) { where email: email}

  def attendance_list
    self.attendances
  end

  def attendance_record
    if attendance_list.present?
      percentage = (attendance_list.select { |a| a.attend? }.count * 100 / attendance_list.count).to_s(:percantage)
    end
  end

  def attendance_breakdown
    {
      "Attend" => attendance_list.attend.count,
      "Skip" => attendance_list.skip.count,
      "Pending" => attendance_list.pending.count,
    }
  end
end
