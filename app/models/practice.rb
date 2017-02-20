class Practice < ApplicationRecord
  include Filterable

  belongs_to :location
  has_many :attendances

  validates :start, :presence => true
  validates :date, date: { allow_blank: false }, :uniqueness => true
  validates :location_id, :presence => true

  enum status: { active: 0, cancelled: 1, pending: 2 }

  scope :status, ->(status) { where(status: Practice.statuses[status]) }
  scope :date, ->(date) { where date: date }

  def self.created_after(time)
    where("created_at >= ?", time) if time.present?
  end

  def self.after(date)
    where("date >= ?", date) if date.present?
  end

  def after?(date)
    self.date >= date.to_date
  end

  def as_json(options={})
      super(:include => {
              :location => {
                :only => [:address, :name]
              }
            }
      )
  end

  def attendees
    self.attendances.includes(:player)
  end
end
