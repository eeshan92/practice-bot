class Player < ApplicationRecord
  include Filterable
  attr_accessor :attendance_record

  has_many :attendances
  has_many :practices, :through => :attendances

  belongs_to :user

  validates :full_name, presence: true

  enum gender: { male: 0, female: 1 }

  scope :full_name, ->(full_name) { where full_name: full_name }
  scope :handle, ->(handle) { where handle: handle }
  scope :foreign_id, ->(id) { where foreign_id: id }
  scope :gender, ->(gender) { where gender: gender }
  scope :phone, ->(phone) { where phone: phone }
  scope :NRIC, ->(nric) { where NRIC: nric }
  scope :email, ->(email) { where email: email}

  def attendance_record(attendances = nil)
    attendances ||= default_attendance_list
    if attendances.present?
      percentage = (attendances.select do |a|
        a.attend? || a.late? || a.other?
      end.count * 100 / attendances.count)
    else
      0
    end.to_s(:percentage, precision: 1)
  end

  def attendance_breakdown(attendances = nil)
    attendances ||= default_attendance_list
    {
      "Attend" => attendances.attend.count,
      "Skip" => attendances.skip.count,
      "Pending" => attendances.pending.count,
      "Late" => attendances.late.count,
      "Others" => attendances.other.count
    }
  end

  def default_attendance_list
    Attendance.where(player_id: self.id)
  end
end
