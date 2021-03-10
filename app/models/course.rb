class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_and_belongs_to_many :categories, dependent: :destroy
  has_many :promotions, dependent: :destroy

  validates :title, presence: true

  scope :teacher, -> (teacher_id) { where("teacher_id = ?", teacher_id) }

end
