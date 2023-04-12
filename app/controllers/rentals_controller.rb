class RentalsController < ApplicationController
  
  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params.merge(user_id: current_user.id))
    @product = @rental.product
    if @rental.valid?
      @rental.save
      redirect_to root_path
    else
      if !@rental.valid_date
        flash["message"] = 'Invalid dates selected! Please, check the dates and try again.'
      elsif @rental.duplicate_rental
        flash["message"] = @rental.return_available_dates
      end
      redirect_to new_rental_path
    end
  end

  def update
    @rental = Rental.find_by_id(params[:id])
    @user = User.find_by_id(params[:id])
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :product_id)
  end
end