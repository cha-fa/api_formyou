class Promotion < ApplicationRecord
  belongs_to :course
  belongs_to :classroom
  has_many :subscriptions, dependent: :destroy
  has_many :students, through: :subscriptions
  
  validates :start_date,
  presence: true,
  if: :future_date
      
  scope :teacher, -> (teacher_id) {joins(:course).where("courses.teacher_id = ?", teacher_id) }

  def future_date
    errors.add(:start_date, "The start date can't be in the past") unless start_date > DateTime.now
  end

  def clean_start_date
    self.start_date.strftime("%B %d, %Y")
  end

  def clean_start_hour
    self.start_date.strftime("%l:%M %P")
  end
end
