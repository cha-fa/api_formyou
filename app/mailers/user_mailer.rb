class UserMailer < ApplicationMailer
  default from: 'admin-formyou@yopmail.com'
  
  @url = "https://formyou.herokuapp.com/"

  def welcome_email(user)
    @user = user
    mail(from: "admin-formyou@yopmail.com", to: @user.email,
          subject: "welcome email")
  end

  def email_approval(user)
    @user = user
    mail(from: "admin-formyou@yopmail.com", to: @user.email,
          subject: "your account has been approved")
  end

  def suscription_confirmation_email(subscription)
    @user = User.find(subscription.student_id)
    @promotion = subscription.promotion
    @course = subscription.promotion.course
    mail(from: "admin-formyou@yopmail.com", to: @user.email,
        subject: "You are signed up for the " + @course.title + " course on " + @promotion.clean_start_date)
  end
end
