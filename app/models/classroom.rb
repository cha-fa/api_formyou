class Classroom < ApplicationRecord
  validates :title, presence: true
  has_many :sessions
end
