class Subscription < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :promotion

  after_create :send_suscription_confirmation_email

  def send_suscription_confirmation_email
    UserMailer.suscription_confirmation_email(self).deliver_now
  end

end
