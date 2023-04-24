class UserMailer < ApplicationMailer

  def email_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm Your Email')
  end
end