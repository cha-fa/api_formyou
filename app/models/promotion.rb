class Promotion < ApplicationRecord
  belongs_to :course
  belongs_to :classroom
  has_many :subscriptions, dependent: :destroy
  has_many :students, through: :subscriptions

  validates :start_date, presence: true, if: :future_date

  scope :teacher,
        ->(teacher_id) {
          joins(:course).where('courses.teacher_id = ?', teacher_id)
        }
  scope :future, -> { where('start_date > ?', Date.today) }
  scope :past, -> { where('start_date < ?', Date.today) }

  MAXIMUM_CAPACITY = 20

  def remaining_seats
    return MAXIMUM_CAPACITY - self.subscriptions.size
  end

  def with_details
    self.attributes.merge(
      remaining_seats: self.remaining_seats,
      course_title: self.course.title,
      clean_start_date: self.clean_start_date,
      teacher_name: self.course.teacher.first_name,
    )
  end

  def is_full?
    self.remaining_seats < 1 ? true : false
  end

  def future_date
    unless start_date > DateTime.now
      errors.add(:start_date, "The start date can't be in the past")
    end
  end

  def clean_start_date
    self.start_date.strftime('%B %d, %Y')
  end
end
