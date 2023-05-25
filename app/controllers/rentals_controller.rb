class RentalsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy rate_salon]
  before_action :set_rental, only: %i[show edit update destroy rate_salon]

  def new
    @rental = Rental.new
  end

  def show; end

  def create
    @rental = current_user.rentals.new(rental_params)
    if @rental.save
      ConfirmationEmailWorker.perform_async(@rental.id)
      redirect_to @rental, notice: 'Request for confirming the rental has been send to the owner.'
    else
      redirect_to new_rental_path, notice: 'Something went wrong Please, try again.'
    end
  end

  def confirm
    @rental = Rental.find_by(confirmation_token: params[:confirmation_token], id: params[:rental_id])

    if @rental.present?
      @rental.confirmed!
      redirect_to @rental, notice: 'Rental has been confirmed.'
      UserRentalConfirmationEmailWorker.perform_async(@rental.id)
    else
      redirect_to root_url, alert: 'Invalid confirmation token.'
    end
  end

  def rate_salon
    render 'rentals/rate_salon'
  end

  def update_rating
    @rental = Rental.find(params[:rental_id])
    @rental.update(rating_params)
    @rental.product.salon.update_salon_rating
    redirect_to @rental.product.salon, notice: 'Thank you for rating your rental!'
  end

  def edit
    render 'rentals/_edit'
  end

  def update
    @rental.assign_attributes(rental_params)
    if @rental.update(rental_params)
      redirect_to @rental, notice: 'Rental was successfully updated.'
    else
      redirect_to edit_rental_path, alert: @rental.errors.full_messages.join(', ')
    end
  end

  def export_csv
    rentals = Rental.all

    send_data CsvExporter.call(rentals), filename: "Rentals-statistics-#{Date.today}.csv", type: 'text/csv'
  end

  def destroy
    return unless @rental.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Rental was successfully destroyed.' }
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :product_id, :status)
  end

  def rating_params
    params.require(:rental).permit( :user_rating)
  end
end
