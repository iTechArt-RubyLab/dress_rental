module Admin
  class SalonsController < AdminController
    before_action :set_salon, only: %i[edit update destroy]

    def new
      @salon = Salon.new
    end

    def create
      @salon = Salon.new(salon_params)

      respond_to do |format|
        if @salon.save
          format.html { redirect_to salon_path(@salon), notice: "Salon was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      if @salon.update(salon_params)
        flash.now[:notice] = 'Salon successfully updated.'
        redirect_to salon_path(@salon)
      else
        render :edit
        flash.now[:error] = 'Could not save the changes.'
      end
    end

    def destroy
      @salon.destroy

      respond_to do |format|
        format.html { redirect_to admin_salons_path, notice: "Salon was successfully destroyed." }
      end
    end

    private

    def set_salon
      @salon = Salon.find(params[:id])
    end

    def salon_params
      params.require(:salon).permit(:name, :description, :owner_id)
    end
  end
end
