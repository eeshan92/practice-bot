class Player < ApplicationRecord
  include Filterable

  has_many :attendances

  validates :name, presence: true

  enum gender: { male: 0, female: 1 }

  # scope :name, ->(name) { where name: name }
  scope :handle, ->(handle) { where handle: handle }
  scope :foreign_id, ->(foreign_id) { where foreign_id: foreign_id }
  scope :gender, ->(gender) { where gender: gender }
end
