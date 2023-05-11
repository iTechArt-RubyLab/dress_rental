class RentalsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_rental, only: %i[show edit update destroy]

  def new
    @rental = Rental.new
  end

  def show; end

  def create
    @rental = current_user.rentals.new(rental_params)
    if @rental.save
      redirect_to @rental, notice: 'Rental was successfully created.'
    else
      redirect_to new_rental_path, alert: @rental.errors.full_messages.join(', ')
    end
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
    params.require(:rental).permit(:start_date, :end_date, :product_id)
  end
end
