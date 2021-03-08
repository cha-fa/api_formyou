class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_and_belongs_to_many :categories

  validates :title, presence: true

end
