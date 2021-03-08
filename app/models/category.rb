class Category < ApplicationRecord
  validates :title, presence: true
  has_and_belongs_to_many :courses
end
