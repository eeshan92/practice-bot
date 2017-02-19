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

  def attendance_list(after_time)
    self.attendances.where(practice_id: Practice.after(after_time))
  end

  def attendance_record(after)
    list = attendance_list(after)
    if list.present?
      percentage = (list.select do |a|
        a.attend? || a.late? || a.other?
      end.count * 100 / list.count)
    else
      0
    end.to_s(:percentage, precision: 1)
  end

  def attendance_breakdown(after)
    list = attendance_list(after)
    {
      "Attend" => list.attend.count,
      "Skip" => list.skip.count,
      "Pending" => list.pending.count,
      "Late" => list.late.count,
      "Others" => list.other.count
    }
  end
end
