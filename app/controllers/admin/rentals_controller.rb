module Admin
  class RentalsController < AdminController
    before_action :set_rental, only: %i[edit update destroy]

    def index
      @rentals = Rental.all
    end

    def edit; end

    def update
      if @rental.update(rental_params)
        redirect_to @rental, notice: 'Rental was successfully updated'
      else
        redirect_to edit_rental_path
        flash[:alert] = @rental.errors.full_messages.join("\n")
      end
    end

    def destroy
      return unless @rental.destroy

      redirect_to admin_rentals_path, notice: 'Rental was successfully destroyed'
    end

    private

    def set_rental
      @rental = Rental.find(params[:id])
    end

    def rental_params
      params.require(:rental).permit(:start_date, :end_date, :product_id)
    end
  end
end
