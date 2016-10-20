class Practice < ApplicationRecord
  include Filterable

  belongs_to :location

  validates :date, date: { allow_blank: false }
  validates :location_id, :presence => true

  enum status: { active: 0, cancelled: 1, pending: 2 }

  scope :status, ->(status) { where status: status }
  scope :date, ->(date) { where date: date }

  def self.created_after(time)
    where("created_at >= ?", time) if time.present?
  end

  def self.after(date)
    where("date >= ?", date) if date.present?
  end
end
