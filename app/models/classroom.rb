class Classroom < ApplicationRecord
  validates :title, presence: true
  has_many :promotions
end
