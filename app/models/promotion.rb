class Promotion < ApplicationRecord
  belongs_to :course
  belongs_to :classroom
  has_many :subscriptions, dependent: :destroy

  validates :start_date,
    presence: true,
    if: :future_date

  MAXIMUM_CAPACITY = 20

  def remaining_seats
    return MAXIMUM_CAPACITY - self.subscriptions.size
  end

  def is_full?
    self.remaining_seats < 1 ? true : false
  end

  def future_date
    errors.add(:start_date, "The start date can't be in the past") unless start_date > DateTime.now
  end

  def clean_start_date
    self.start_date.strftime("%B %d, %Y")
  end
end
