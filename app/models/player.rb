class Player < ApplicationRecord
  has_many :attendances

  validates :name, presence: true

  enum gender: { male: 0, female: 1 }
end
