class RentalMailer < ApplicationMailer
  def rental_confirmation_email
    @rental = params[:rental]
    mail(to: @rental.product.salon.owner.email, subject: 'Новый заказ на аренду') do |format|
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
    mail(to: @rental.user.email, subject: 'Your rental expires less than in 5 days') do |format|
      format.html { render 'mailer/rental_mailer/rental_expiration_notification' }
    end
  end
end