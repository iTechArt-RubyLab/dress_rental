class UserMailer < ApplicationMailer
  def email_confirmation(user)
    @user = user
    @confirmation_url = confirmation_url(confirmation_token: @user.confirmation_token)
    mail(to: @user.email, subject: 'Confirm Your Email')
  end

  def request_owner_access(user)
    @user = user
    mail(to: 'wedding.salon777@gmail.com', subject: 'Запрос прав владельца')
  end
end
