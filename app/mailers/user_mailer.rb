class UserMailer < ApplicationMailer
  def email_confirmation(user)
    @user = user
    @confirmation_url = confirmation_url(confirmation_token: @user.confirmation_token)
    mail(to: @user.email, subject: 'Confirm Your Email')
  end

  def request_owner_access(user)
    @user = user
    mail(to: 'ENV["SENDMAIL_USERNAME"]', subject: 'New owner access request') do |format|
      format.html { render 'mailer/user_mailer/request_owner_access' }
    end
  end
end
