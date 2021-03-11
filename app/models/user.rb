class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable :recoverable, :rememberable, :validatable and :omniauthable

  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  has_many :assigned_courses, foreign_key: 'teacher_id', class_name: 'Course'
  has_many :subscriptions, foreign_key: 'student_id', class_name: 'Subscription'
  has_many :promotions, through: :subscriptions

  enum role: { student: 'student', admin: 'admin', teacher: 'teacher' }

  scope :to_review, -> { where(is_reviewed: false) }
  scope :approved, -> { where(is_approved: true) }
  scope :teachers, -> { where(role: 'teacher') }
  scope :students, -> { where(role: 'student') }

  after_create :send_welcome_email
  after_update :send_email_approval

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def send_email_approval
    UserMailer.email_approval(self).deliver_now
  end
end
