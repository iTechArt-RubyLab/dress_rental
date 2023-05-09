class RentalMailer < ApplicationMailer
  def rental_confirmation_email
    @rental = params[:rental]
    mail(to: @rental.product.salon.owner.email, subject: 'Новый заказ на аренду') do |format|
      format.html { render "mailer/rental_mailer/rental_confirmation_email" }
    end
  end
end