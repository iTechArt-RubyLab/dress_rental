class RentalMailer < ApplicationMailer
  def rental_confirmation_email
    @rental = params[:rental]
    mail(to: @rental.product.salon.owner.email, subject: 'New product order') do |format|
      format.html { render 'mailer/rental_mailer/rental_confirmation_email' }
    end
  end

  def rental_confirmation_notification(rental)
    @rental = rental
    mail(to: @rental.user.email, subject: 'Your rental was successfully confirmed') do |format|
      format.html { render 'mailer/rental_mailer/rental_confirmation_notification' }
    end
  end

  def rental_expiration_notification(rental)
    @rental = rental
    mail(to: @rental.user.email, subject: 'Your rental expires soon!') do |format|
      format.html { render 'mailer/rental_mailer/rental_expiration_notification' }
    end
  end

  def rental_rating_request_notification(rental)
    @rental = rental
    mail(to: @rental.user.email, subject: 'Please, rate your rental!') do |format|
      format.html { render 'mailer/rental_mailer/rental_rating_request_notification' }
    end
  end
end
