module Owner
  class ProductsController < OwnerController
    before_action :set_product, only: %i[show edit update destroy]
    before_action :set_salon, only: %i[new create]

    def new
      @product = Product.new
    end

    def edit; end

    def create
      @product = Product.new(product_params)
      @product.salon = @salon

      respond_to do |format|
        if @product.save
          format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @product.destroy

      respond_to do |format|
        format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      end
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def set_salon
      @salon = Salon.find(params[:salon_id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description)
    end
  end
end