class UserMailer < ApplicationMailer
  default from: 'admin-formyou@yopmail.com'

  def welcome_email(user)
    @user = user 
    mail(from: "admin-formyou@yopmail.com", to: @user.email,
          subject: "email de bienvenue")
  end

  def suscription_confirmation_email(suscription)
    @user = User.find(suscription.student_id)
    mail(from: "admin-formyou@yopmail.com", to: @user.email, 
        subject: "email de confirmation d'inscription à un cours")
  end
end
