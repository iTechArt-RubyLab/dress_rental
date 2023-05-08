module Admin
  class CategoriesController < AdminController
    before_action :set_category, only: %i[edit update destroy]

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to category_path(@category), notice: "Category was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to @category, notice: 'Category successfully updated.'
      else
        render :edit
        flash.now[:error] = 'Could not save the changes.'
      end
    end

    def destroy
      @category.destroy

      respond_to do |format|
        format.html { redirect_to admin_categories_path, notice: "Category was successfully destroyed." }
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
end
