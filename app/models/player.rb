class Player < ApplicationRecord
  include Filterable

  has_many :attendances

  validates :full_name, presence: true

  enum gender: { male: 0, female: 1 }

  scope :full_name, ->(full_name) { where full_name: full_name }
  scope :handle, ->(handle) { where handle: handle }
  scope :foreign_id, ->(id) { where foreign_id: id }
  scope :gender, ->(gender) { where gender: gender }
end
